//
//  HomeTabViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import Foundation
import UIKit
import Tabman
import Pageboy
import SnapKit

class HomeTabViewController: TabmanViewController {

    
    
    let customContainer = UIView()
    
    let titleLabel = UILabel().then {
        $0.text = "Home"
        $0.font = UIFont(name: "Avenir-Black", size: 30)
    }
    // Create bar
    let bar = TMBar.ButtonBar()
    

    
    let TagViewBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "tag"), for: .normal)
        $0.addTarget(self, action: #selector(pushTagView), for: .touchUpInside)
    }
    
    // 페이징 할 뷰 컨트롤러
    var viewControllers: Array<UIViewController> = [HomeViewController(),TagViewController()]
//    var viewControllers: Array<UIViewController> = [,TagViewController()]

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.dataSource = self
        self.bounces = false
        
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .custom(view: customContainer, layout: { (bar) in
            bar.snp.makeConstraints { make in
//                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            }))
        
        print("HomeTabView")
        setUI()
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(TagViewBtn)
        view.addSubview(customContainer)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        TagViewBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(40)
        }
        
        customContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .snap
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
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
        ctBar.indicator.tintColor = UIColor.customColor(.pointColor)
    }
    
    
    @objc func pushTagView(){
        let nextVC = AddTagViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}



extension HomeTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
  
  func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
 
      // MARK: -Tab 안 글씨들
      switch index {
      case 0:
          return TMBarItem(title: "Keyword Post")
      case 1:
          return TMBarItem(title: "Keyword List")
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
