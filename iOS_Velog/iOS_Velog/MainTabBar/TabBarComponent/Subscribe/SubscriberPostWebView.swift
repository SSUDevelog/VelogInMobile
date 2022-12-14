//
//  TagPostWebView.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/14.
//

import UIKit
import WebKit
import NVActivityIndicatorView
import RxSwift
import SwiftSoup
import Alamofire



class SubscriberPostWebView: UIViewController {

//    var isComeFrom: Int = 0
    // isComeFrom == 1 : 홈(태그 추천 뷰)에서 호출한 경우
    // isComeFrom == 2 : 구독자 글 목록 뷰에서 호출한 경우
    
    var url:String = ""
    var subScribeName: String = ""
    
    lazy var loadingBgView: UIView = {
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        bgView.backgroundColor = .systemBackground

        return bgView
    }()
    
    var activityIndicator: NVActivityIndicatorView = {
            // ✅ activity indicator 설정
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40),
                                                        type: .ballBeat,
                                                        color: .gray,
                                                        padding: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        return activityIndicator
    }()
    
    private func setActivityIndicator() {
            // 불투명 뷰 추가
            view.addSubview(loadingBgView)
            // activity indicator 추가
            loadingBgView.addSubview(activityIndicator)

            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

            // 애니메이션 시작
            activityIndicator.startAnimating()
    }
    
    let webView : WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        setActivityIndicator()
        
//        webView.load(URLRequest(url: PostWebViewController.url!))

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.Queue()
        
        loadPostWebView()

        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // check network
        guard Reachability.networkConnected() else {
            let alert = UIAlertController(title: "NetworkError", message: "네트워크가 연결되어있지 않습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "종료", style: .default) { (action) in
                exit(0)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
    }


    func loadPostWebView(){
        
        if SubScribeTableViewController.url != ""{
                
            let urlString = "https://velog.io\(SubScribeTableViewController.url)"
            //            print(urlString)
            guard let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
            let PostURL = URL(string: encodedStr)!
            //            print("url")
            print(PostURL.absoluteString)
            //            print(PostURL)
            webView.load(URLRequest(url: PostURL)) // !가능 할 것 같은데
//               self.crawl(inputUrl: encodedStr)
            }else{
                print("해당하는 URL이 존재하지 않습니다.")
            }
    }
    
    func loadPostWebViewForTag(){
        if HomeViewController.url != ""{
            
            let urlString = "https://velog.io\(HomeViewController.url)"
//            print(urlString)
            guard let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
            let PostURL = URL(string: encodedStr)!
//            print("url")
            print(PostURL.absoluteString)
//            print(PostURL)
            webView.load(URLRequest(url: PostURL)) // !가능 할 것 같은데
        }else{
            print("해당하는 URL이 존재하지 않습니다.")
        }
    }
    
    func crawl(inputUrl:String){
        let url = URL(string: inputUrl)
        
        guard let myURL = url else {   return    }
        
        
        AF.request(myURL).responseString { (response) in
            guard var html = response.value else {
                return
            }
            
            if let data = response.data {
                let encodedHtml = NSString(data: data, encoding: CFStringConvertEncodingToNSStringEncoding( 0x0422 ) )
                if let encodedHtml = encodedHtml {
                    html = encodedHtml as String
                }
            }
            
            do {
                //            let html = try String(contentsOf: myURL, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
//                let headerTitle = try doc.title()
//                print(headerTitle)
                print(doc)
                // #newsContents > div > div.postRankSubjectList.f_clear
//                let elements: Elements = try doc.select("#root > div.sc-efQSVx.kdrjec.sc-cTAqQK.gdjBUK > div.sc-jUosCB.gbQfRh")
//                for element in elements {
//                    print(try element.select("div > div"))
//                }

            }catch {
                print("error")
            }
            
        }
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    
    func Queue(){
        DispatchQueue.main.async {
            self.setActivityIndicator()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // 애니메이션 정지.
                // 서버 통신 완료 후 다음의 메서드를 실행해서 통신의 끝나는 느낌을 줄 수 있다.
                self.activityIndicator.stopAnimating()
                self.loadingBgView.removeFromSuperview()
        }
    }
    
    
}


