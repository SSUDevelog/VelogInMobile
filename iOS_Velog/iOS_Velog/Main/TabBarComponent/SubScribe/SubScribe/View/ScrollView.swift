//
//  ScrollView.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/18.
//
//
import UIKit
import Then
import SnapKit

class ScrollView: UIView {
    
    let scrollView = UIScrollView().then{
//        $0.backgroundColor = .red
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var contentView: UIView = {
      let contentView = UIView()
//      contentView.backgroundColor = .green
      contentView.translatesAutoresizingMaskIntoConstraints = false
      return contentView
    }()
    
    lazy var stackView: UIStackView = {
        //arrangedSubviews <- 안에 있는 값은 클래스에서 불러온값
        let stackV = UIStackView()
        stackV.translatesAutoresizingMaskIntoConstraints = false
        stackV.axis = .vertical
        stackV.spacing = 170
        stackV.distribution = .fillEqually
        return stackV
    }()

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)
        
        setViewHierarchy()
        setConstraints()

    }
    
    func setViewHierarchy(){
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        // 여기 for 문으로 post 개수 바뀐다
        for _ in 0..<10 {
            let view = PostView()
//            view.backgroundColor = .yellow
            stackView.addArrangedSubview(view)
        }
    }
    
    func setConstraints(){
        scrollView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.right.equalTo(scrollView.snp.right)
            make.left.equalTo(scrollView.snp.left)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
            make.left.equalTo(contentView.snp.left)
            make.bottom.equalTo(contentView.snp.bottom)
        }

        for view in stackView.arrangedSubviews {
          NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalToConstant: 100)
          ])
        }

    }
}
