//
//  CrowlViewContorller.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/10.
//

import Foundation
import SwiftSoup
import UIKit
class CrawlViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        crawl()
    }
}

func crawl(){
    let url = URL(string: "https://www.aladin.co.kr/shop/common/wbest.aspx?BranchType=1&start=we")

    guard let myURL = url else {   return    }

    do {
        let html = try String(contentsOf: myURL, encoding: .utf8)
        let doc: Document = try SwiftSoup.parse(html)
        let headerTitle = try doc.title()
        print(headerTitle)

        let firstLinkTitles:Elements = try doc.select(".bo3").select("b") //.은 클래스
        for i in firstLinkTitles {
            print("title: ", try i.text())
        }


    } catch Exception.Error(let type, let message) {
        print("Message: \(message)")
    } catch {
        print("error")
    }

}

