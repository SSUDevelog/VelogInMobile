//
//  MyWebview.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/18.
//
import UIKit
import WebKit
import Moya

class MyWebViewContoller: UIViewController {
    
    // 일단 임시 !!!
    private let provider = MoyaProvider<SubscriberService>()
    var responseData: SubscriberListResponse?
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://velog.io/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        self.getServer()
    }
    
    
    // 일단 임시 !!!
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
                    print(userList.List)
                    
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
