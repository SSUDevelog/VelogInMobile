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

        // 임시 url !! 더미 데이터
        guard let url = URL(string: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85") else { return }
        
        webView.load(URLRequest(url: url))

        self.Queue()
        
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


