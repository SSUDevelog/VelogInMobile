//
//  PostWebViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/28.
//

import UIKit
import WebKit
import NVActivityIndicatorView
import RxSwift

class PostWebViewController: UIViewController {
    
    // 일단 더미, static
//    static var url:URL?
    
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
        
        
        loadPostWebView()
        
        self.Queue()
        
    }
    
    let serverURL = "https://velog.io/@bricksky/HCI-스터디-2주차"
    let realURL = "https://velog.io/@bricksky/HCI-%EC%8A%A4%ED%84%B0%EB%94%94-2%EC%A3%BC%EC%B0%A8"
    
    let dummyURL = "https://stackoverflow.com/questions/24410473/how-to-convert-this-var-string-to-url-in-swift"
    
    
    func loadPostWebView(){
        if SubScribeCollectionViewController.url != ""{
            
            let urlString = "https://velog.io\(SubScribeCollectionViewController.url)"
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


