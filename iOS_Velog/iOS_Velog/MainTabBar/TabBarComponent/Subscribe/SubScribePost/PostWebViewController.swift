//
//  PostWebViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/28.
//

import UIKit
import WebKit

class PostWebViewController: UIViewController {
    
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
        
        // 임시 url !! 더미 데이터
        guard let url = URL(string: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85") else { return }
        
        webView.load(URLRequest(url: url))

        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
}
