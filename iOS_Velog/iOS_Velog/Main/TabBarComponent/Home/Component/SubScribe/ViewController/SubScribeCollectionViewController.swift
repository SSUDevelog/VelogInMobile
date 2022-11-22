//
//  SubScribeCollectionViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import UIKit
import SnapKit
import Then
import Moya

class SubScribeCollectionViewController: UIViewController {
    
    private let provider = MoyaProvider<SubscriberService>()
    
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
        }
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getServer()
        self.getPostDataServer()
    }
    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    print(moyaResponse.statusCode)
                    print(try moyaResponse.mapJSON())
//                    var responseData = try moyaResponse.mapJSON()
//                    var responseDataa = try JSONSerialization.
                    print("과연 성공?")
                    
//                    print(responseDataa)
//                    print("과연 성공?")
                    print("성공")  // 여기까지는 들어온다.
                    
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
//                     이거 임시!!!
                    NotificationList.notificationList = try moyaResponse.mapJSON() as! [String]
                    print(userList.List)
                    
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
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
