//
//  ScrollView.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/18.
//

import UIKit
import Then
import SnapKit

class ScrollView: UIView {

    private let scrollView = UIScrollView().then {
        $0.automaticallyAdjustsScrollIndicatorInsets = false
//        $0.backgroundColor = .gray
    }
    
    var topView = TopView()
    
    func topViewCus(){
        topView.backgroundColor = .gray
    }
    
    var underView = UnderBar()
    
    var stackView = UIStackView().then{
        $0.axis = .vertical
        $0.spacing = 80
        $0.distribution = .fillProportionally
//        $0.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setViewHierarchy()
        setConstraints()
        topViewCus()
    }
    
    func setViewHierarchy(){
        addSubview(scrollView)
        stackView.addArrangedSubview(topView)
//        stackView.addArrangedSubview(underView)
        scrollView.addSubview(stackView)
        
    }
    
    func setConstraints(){
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        stackView.snp.makeConstraints {
//           $0.top.equalTo(scrollView.snp.top)
//           $0.bottom.equalTo(scrollView.snp.bottom)
           $0.width.equalTo(scrollView.snp.width)
        }
    }

}
