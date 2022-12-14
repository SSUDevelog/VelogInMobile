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
import SwiftSoup
import Alamofire
import Moya



class PostWebViewController: UIViewController {

    private let provider = MoyaProvider<SubscriberService>()
    
    var didTouchedSubscribe = false
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
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "구독추가", style: .plain, target: self, action: #selector(buttonPressed(_:)))
        button.tag = 2
        button.tintColor = UIColor.customColor(.pointColor)
        return button
    }()
    
    init(url:String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //super.init(coder: coder) 이것도 됨
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        setActivityIndicator()
        
//        webView.load(URLRequest(url: PostWebViewController.url!))

        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        self.Queue()
        
        loadPostWebView()
    
        self.navigationItem.rightBarButtonItem = self.rightButton
        
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
            if HomeViewController.url != ""{
                
                let urlString = "https://velog.io\(HomeViewController.url)"
    //            print(urlString)
                guard let encodedStr = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
                let PostURL = URL(string: encodedStr)!
    //            print("url")
                print(PostURL.absoluteString)
    //            print(PostURL)
                webView.load(URLRequest(url: PostURL)) // !가능 할 것 같은데
                self.crawl(inputUrl: encodedStr)
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
//                print(doc)
                // #newsContents > div > div.postRankSubjectList.f_clear
                
//                let elements: Elements = try doc.select("#root > sc-efQSVx kdrjec sc-cTAqQK gdjBUK > sc-jUosCB gbQfRh > sc-hOGkXu ljCkfJ > sc-dtMgUX uWDEh atom-one")
                
                let html = try doc.text()
//                print (html)
                
                // [특정 첫번째 태그 선택 : p 태그]
                let title: Element = try doc.select("h1").first()!
                let userName: Element = try doc.select("span").first()!
                let postDate: Element = try doc.select("span").get(2)
            
                
                // [텍스트 내용 출력 실시]
                let text = try title.text()
                let user = try userName.text()
                let date = try postDate.text()

                
//                print("tag : ", tag)
                print("text : ", text)
                print("user : ", user)
                print("date : ", date)
                
                
                
                
//                for element in elements {
//                    print(try element.select(element.))
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
    
    // Button event.
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIBarButtonItem {
            switch button.tag {
            case 1:
                break
            case 2:
                var value:Int = 0
                for char_data in url {
                    
                    // 중복 터치 방지
                    if self.didTouchedSubscribe == true {
                        return
                    }
                    
                    if char_data == "/" {
                        value += 1
                        if value == 2 {
                            break
                        }
                    }else if char_data == "@" {
                        continue
                    }else {
                        subScribeName.append(char_data)
                    }
                }
                self.didTouchedSubscribe = true
                print(subScribeName)
                
                // 이미 구독한 사람이면
                if checkDoubleSubscription(inputId: subScribeName) == false {
                    let alertForOut = UIAlertController(title: "이미 구독한 사용자입니다.", message: "구독자 리스트를 확인해주세요.", preferredStyle: UIAlertController.Style.alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: { okAction in
                        return
                    })
                    alertForOut.addAction(okAction)
                    present(alertForOut,animated: true,completion: nil)
                    
                }else {
                    // 구독한 사람이 아니면
                    let alert = UIAlertController(title: "구독자 추가", message: "해당 글을 쓴 유저를 구독하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
                    
                    let SuccessAlert = UIAlertController(title: "성공", message: "구독자로 추가 되었습니다.", preferredStyle: UIAlertController.Style.alert)
                    
                    let okActionForSuccessAlert = UIAlertAction(title: "확인", style: .default,handler: {noAction in
                        return
                    })
                    
                    let okAction = UIAlertAction(title: "네", style: .default, handler: { okAction in
                        self.addSubscriber(Id: self.subScribeName)
                        
                        SuccessAlert.addAction(okActionForSuccessAlert)
                        self.present(SuccessAlert,animated: true,completion: nil)
                    })
                    
                    let noAction = UIAlertAction(title: "아니요", style: .destructive,handler: {noAction in
                        return
                    })
                    
                    alert.addAction(okAction)
                    alert.addAction(noAction)
                    present(alert, animated: true, completion: nil)
                    
                    
                    
                }
            default:
                print("error")
            }
        }
    }
    
    // 구독하려는 아이디가 구독리스트에 있는지 체크하는 메소드
    func checkDoubleSubscription(inputId:String)->Bool{
        for list in userList.List {
            if list == inputId {
                return false
            }
        }
        return true
    }
    
    // 구독자 최종 추가
    func addSubscriber(Id:String){
        let param = AddRequest(SignInViewController.FcmToken, Id)
        self.provider.request(.addSubscriber(param: param)){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    print("최종추가됨")
                    
                    
                    self.getServer()
                    self.getPostDataServer()
                    
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    // 구독자 추가했을 경우 서버 디비 재호출
    func getServer(){
        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
                    
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    
                    print(moyaResponse.statusCode)
                    PostData.Post = try moyaResponse.map(PostList.self)
                    
                    self.resetURL(indexSize: PostData.Post.subscribePostDtoList.count)
                    
                    print("성공")
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func resetURL(indexSize:Int){
        
        urlList.list.removeAll()
        
        for x in 0..<indexSize {
            urlList.list.append(PostData.Post.subscribePostDtoList[x].url)
        }
        
        for x in 0..<indexSize {
            print(urlList.list[x])
        }
        
        self.didTouchedSubscribe = false
        
    }

}


