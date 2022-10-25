//
//  MyWebview.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/18.
//
import UIKit
import WebKit
class MyWebViewContoller: UIViewController {
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
        }
}
