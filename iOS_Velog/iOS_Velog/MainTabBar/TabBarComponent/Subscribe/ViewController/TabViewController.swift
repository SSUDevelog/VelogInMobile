//
//  TabManViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/21.
//

import Foundation
import UIKit
import Tabman
import Pageboy
import SnapKit

class TabViewController: TabmanViewController {

    let customContainer = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "Subscribe"
        $0.font = UIFont(name: "Avenir-Black", size: 30)
    }
    // Create bar
    let bar = TMBar.ButtonBar()
    

    
    // 구독 검색 버튼
    let addButton = UIButton().then{
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.addTarget(self, action: #selector(addSubscribe), for: .touchUpInside)
    }
    
    // 페이징 할 뷰 컨트롤러
    var viewControllers: Array<UIViewController> = [SubScribeCollectionViewController(),SubscribeListViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .custom(view: customContainer, layout: { (bar) in
            bar.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            }))

        setUI()
//        addBar(bar, dataSource: self, at: .top)

        
    }
    
    func setUI(){        
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(customContainer)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(40)
        }
        
        customContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 50.0, bottom: 0.0, right: 50.0)
        
        // 간격
        ctBar.layout.interButtonSpacing = 60
            
        ctBar.backgroundView.style = .blur(style: .light)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = UIColor.black
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 16)
            button.selectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = UIColor.black
    }
    
    @objc func addSubscribe(){
        print("pushView")
        let nextVC = SearchSubscribeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}



extension TabViewController: PageboyViewControllerDataSource, TMBarDataSource {
  
  func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
 
      // MARK: -Tab 안 글씨들
      switch index {
      case 0:
          return TMBarItem(title: "Following Post")
      case 1:
          return TMBarItem(title: "Following List")
      default:
          let title = "Page \(index)"
          return TMBarItem(title: title)
      }

  }
  
  func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
      //위에서 선언한 vc array의 count를 반환합니다.
      return viewControllers.count
  }

  func viewController(for pageboyViewController: PageboyViewController,
                      at index: PageboyViewController.PageIndex) -> UIViewController? {
      return viewControllers[index]
  }

  func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
      return nil
  }
}

