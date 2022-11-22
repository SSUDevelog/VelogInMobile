//
//  SubScribeCollectionViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import UIKit
import SnapKit
import Then

class SubScribeCollectionViewController: UIViewController {
    private var collectionView:UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height/3)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }
        
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        
    }

}

extension SubScribeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
//        cell.contentView.backgroundColor = .systemBlue
//        cell.configure(title: "Custom \(indexPath.row)", textViewText: <#T##String#>, name: <#T##String#>, date: <#T##String#>)
        // 이걸로 cell 초기화!!
        return cell
    }
    
    

}
