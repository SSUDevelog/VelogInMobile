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
        $0.backgroundColor = .red
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var contentView: UIView = {
      let contentView = UIView()
      contentView.backgroundColor = .green
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

        for _ in 0..<10 {
          let view = PostView()
          view.backgroundColor = .blue
          stackView.addArrangedSubview(view)
        }
    }
    
    func setConstraints(){
        scrollView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }

        NSLayoutConstraint.activate([
          contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
          contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
          contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
          contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
          contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])

        NSLayoutConstraint.activate([
          stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
          stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
          stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
          stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        ])

        for view in stackView.arrangedSubviews {
          NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 100),
            view.heightAnchor.constraint(equalToConstant: 100)
          ])
        }

    }
    

}
