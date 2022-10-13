//
//  TabBarViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//
import Foundation
import UIKit
import SnapKit


class CustomTabBarController: UITabBarController{
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    let homeVC = HomeViewController()
    let subScribeVC = SubScribeViewController()
    let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    


    func setUpTabBar(){
        self.tabBar.tintColor = UIColor.customColor(.pointColor)
        self.tabBar.unselectedItemTintColor = .white
        self.tabBar.backgroundColor = UIColor.customColor(.defaultBlackColor)

        homeVC.title = "Home"
        subScribeVC.title = "Subscribe"
        profileVC.title = "Profile"

        let ViewControllers:[UIViewController] = [homeVC,subScribeVC,profileVC]
        // assign view controllers to tab bar
        self.setViewControllers(ViewControllers, animated: true)

        homeVC.tabBarItem.image = UIImage(systemName: "house")
        subScribeVC.tabBarItem.image = UIImage(systemName: "command")
        profileVC.tabBarItem.image = UIImage(systemName: "person")
        
        //네비게이션 뷰컨으로 푸쉬했을 때 밑에 바가 사라지지 않도록
        self.hidesBottomBarWhenPushed = false
        viewWillLayoutSubviews()
    }
}

