//
//  SearchSubscribeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit
import SnapKit
import Then
import Realm
import RealmSwift
import Moya

class SearchSubscribeViewController: UIViewController{

    // for server
    private let provider = MoyaProvider<SubscriberService>()
//    var subScriberData: SubscriberModel?
    var responseData: SubscriberResponse?
    
    
    var realm = RealmService()
    
    let searchController = UISearchController(searchResultsController: nil)

    
//    private let tableView: UITableView = {
//        let tableview = UITableView()
//        return tableview
//    }()
    
//    var dummyData:[String] = ["Aaliyah","Aaron","Olivia","Hazel","Lily","Zoe","Grace","Ava","Isabella","Harry","Liam","Lucas","Declan","Elliot","Owen","Theodore","Jasper","Oskar","Tyler","Jade","Cameron","Kailani","Rochella","Floriana","Melody","Agata","Mia"]
    
    // fillerArr
//    var filteredArr: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.setupSearchController()
//        self.setupTableView()
        
        // UI
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UI 설계가 아직 안나와서 일단 여기에
        postServer()  // 일단 여기 막을게
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 키보드 올리기
        self.searchController.searchBar.resignFirstResponder()
        
    }
    

    func setupSearchController(){
        // Do any additional setup after loading the view.
        navigationItem.title = "Subscribe Search"
                
        // navigation item 에 searchController 추가
        navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.automaticallyShowsCancelButton = false

        // text 입력할 때 마다 업데이트 될 부분
//        searchController.searchResultsUpdater = self
        
        // keyboard up -> not finish
//        searchController.becomeFirstResponder()
    }
    
//    func setupTableView(){
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//    }
    
    func setUI(){
        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
        
//        tableView.snp.makeConstraints{
//            $0.top.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-20)
//        }
    }
    

//
//    var isFiltering: Bool {
//        let searchController = self.navigationItem.searchController
//        let isActive = searchController?.isActive ?? false
//        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
//        return isActive && isSearchBarHasText
//    }
    
    func showAlert(velogId:String){
        let alert = UIAlertController(title: "Want to subscribe?", message: "will be added to the subscription list", preferredStyle: UIAlertController.Style.alert)

        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil) // 여기에 클로저 형태로 이후 이벤트 구현
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in   // 여기에 클로저 형태로 이후 이벤트 구현
            self.makeSubscribe(velogId: velogId)
        })
        
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    // showAlert에서의 okAction (구독 최종 추가 함수)
    func makeSubscribe(velogId:String){
//        realm.add(item: velogId)
        realm.add(item: velogId)
    }
    
    func postServer(){
        // server
        let param = AddRequest.init("temporaryFCMToken", "aqaqsubin")  // 여기에 들어가야 한다!!
        print(param)
        self.provider.request(.addSubscriber(param:param)){ response in
            switch response {
                case .success(let moyaResponse):
                    do {
                        print(moyaResponse.statusCode)
                        print("여기야!!!")
//                        print(moyaResponse.response)
                        self.getServer()
                    } catch(let err) {
                        print(err.localizedDescription)
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
                    
//                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
//                    print(self.subScribeList)   // 서버에서 구독자 리스트 받아와서 subscriberList 에 저장
                
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

extension SearchSubscribeViewController: UISearchBarDelegate{
        private func dissmissKeyboard() {
//            self.searchBar.resignFirstResponder()
            self.searchController.searchBar.resignFirstResponder()
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // 검색 시작
            //키보드가 올라와 있을떄, 내려가게
            dissmissKeyboard()
            // 검색어가 있는지
            guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
            print("--> 검색어: \(searchTerm)")
            
        }
        
}











//extension SearchSubscribeViewController:UITableViewDelegate, UITableViewDataSource{
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dummyData.count
//        return self.isFiltering ? self.filteredArr.count : self.dummyData.count
//        return 1
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell()
//        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        if self.isFiltering {
//        cell.textLabel?.text = self.filteredArr[indexPath.row]
//        } else {
//            cell.textLabel?.text = self.dummyData[indexPath.row]
//        }
//        return cell
//    }
    
    // cell 클릭 시 생기는 alert
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var str = dummyData[indexPath.row]  // 일단 이렇게 두면 서치하지 않은 상태에서 dummy data 에서는 로컬에 추가 된다
//        if self.isFiltering{
//            str = self.filteredArr[indexPath.row]
//        } else {
//            str = self.dummyData[indexPath.row]
//        }
//
//        showAlert(velogId: str)  // ""안에 table cell의 label String이 들어가면 된다.
//        print("cell touched")
//    }
    



//extension SearchSubscribeViewController: UISearchResultsUpdating{
//    func updateSearchResults(for searchController: UISearchController) {
////        searchController의 searchBar text를 Print -> 이렇게 Search Bar 업데이트를 볼 수 있다
//        dump(searchController.searchBar.text)
//        guard let text = searchController.searchBar.text?.lowercased() else { return }
////        self.filteredArr = self.dummyData.filter { $0.localizedCaseInsensitiveContains(text) }
//        self.tableView.reloadData()
//
//        dump(filteredArr)
//    }
//}
