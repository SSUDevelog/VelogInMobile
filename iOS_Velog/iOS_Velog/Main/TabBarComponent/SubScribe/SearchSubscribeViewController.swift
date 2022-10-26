//
//  SearchSubscribeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit

class SearchSubscribeViewController: UIViewController {

    let searchController = UISearchController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Subscribe Search"
                
        // navigation item 에 searchController 추가
        navigationItem.searchController = searchController
        
        // UI
        setUI()
    }
    
    func setUI(){
        view.backgroundColor = .systemBackground
    }
    
    


}
