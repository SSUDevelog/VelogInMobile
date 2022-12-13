//
//  TagViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import UIKit
import Foundation
import Then
import SnapKit
import Moya

class TagViewController: UIViewController {
    
    private let provider = MoyaProvider<TagService>()
    
    // 태그 리스트 tableView
    let tableViewForTag :UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        tableViewForTag.register(TagTableCell.self, forCellReuseIdentifier: TagTableCell.identifier)
        tableViewForTag.delegate = self
        tableViewForTag.dataSource = self
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewForTag.reloadData()
    }
    
    func setUI(){

        view.addSubview(tableViewForTag)

        tableViewForTag.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(185)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-90)
        }
    }
    
    // 태그 리스트에서 특정 태그 삭제
    func deleteTagList(targetTag:String){
        self.provider.request(.deletetag(param: targetTag)){ response in
            switch response {
            case .success(let moyaResponse):
                do {    // 여기서 do 가 필요할까?
                    print(moyaResponse.statusCode)
                    self.getTagPostDataServer()
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 태그 맞춤 글 추천 아직 어디에 사용할 지 모름, 이런
    func getTagPostDataServer(){
        self.provider.request(.tagpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPostTag")
                    print(moyaResponse.statusCode)
                    TagPostData.Post = try moyaResponse.map(PostTagList.self)
                    // for test
                    print(TagPostData.Post.tagPostDtoList.count)
                    self.resetTagURL(indexSize: TagPostData.Post.tagPostDtoList.count)
                    print("성공")
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func resetTagURL(indexSize:Int){
        TagaUrlList.list.removeAll()
        
        for x in 0..<indexSize {
            TagaUrlList.list.append(TagPostData.Post.tagPostDtoList[x].url)
        }
    }

    
}

extension TagViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTag.List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagTableCell.identifier) as? TagTableCell ?? TagTableCell()
        cell.bindForTag(model: userTag.List[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//            self.deleteTagList(targetTag: userTag.List.remove(at: indexPath.row))
////            userTag.List.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.endUpdates()
//        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        
        let alert = UIAlertController(title: "키워드 삭제", message: "해당 키워드를 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "예", style: .destructive, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
            print("예")
            tableView.beginUpdates()
            self.deleteTagList(targetTag: userTag.List.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        })
        
        let noAction = UIAlertAction(title: "아니요", style: .default, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
            print("아니요")
        })
        
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
}
    

