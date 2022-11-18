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

class SearchSubscribeViewController: UIViewController, UITextFieldDelegate{

    // for server
    private let provider = MoyaProvider<SubscriberService>()
//    var subScriberData: SubscriberModel?
    var responseData: AddSubscriberResponse?
    
    
    var realm = RealmService()
    
    let searchController = UISearchController(searchResultsController: nil)

    let AddSubscriberBtn = UIButton().then {
        $0.setTitle("구독 추가", for: .normal)
        $0.setTitleColor(UIColor.customColor(.pointColor), for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.addTarget(self, action: #selector(checkVelogUser), for: .touchDown)
    }
    
    let textField = UITextField().then{
        $0.placeholder = "velog 아이디를 입력해주세요."
    }
    
    let label = UILabel().then{
        $0.text = ""
        $0.textColor = UIColor.red
    }

    
//    private let tableView: UITableView = {
//        let tableview = UITableView()
//        return tableview
//    }()
    
//    var dummyData:[String] = ["Aaliyah","Aaron","Olivia","Hazel","Lily","Zoe","Grace","Ava","Isabella","Harry","Liam","Lucas","Declan","Elliot","Owen","Theodore","Jasper","Oskar","Tyler","Jade","Cameron","Kailani","Rochella","Floriana","Melody","Agata","Mia"]
    
    // fillerArr
//    var filteredArr: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        self.setupSearchController()
//        self.setupTableView()
        self.textField.delegate = self  // 필요??
        
        // UI
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // UI 설계가 아직 안나와서 일단 여기에
//        postServer()  // 일단 여기 막을게
        getServer()
    }

//    func setupSearchController(){
        // Do any additional setup after loading the view.
//        navigationItem.title = "Subscribe Search"
                
        // navigation item 에 searchController 추가
//        navigationItem.searchController = searchController
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        searchController.hidesNavigationBarDuringPresentation = false
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//        searchController.automaticallyShowsCancelButton = false

        // text 입력할 때 마다 업데이트 될 부분
//        searchController.searchResultsUpdater = self
        
        // keyboard up -> not finish
//        searchController.becomeFirstResponder()
//    }
    
//    func setupTableView(){
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//    }
    
    func setUI(){
        
        self.textField.autocapitalizationType = .none
        
        view.backgroundColor = .systemBackground
//        view.addSubview(tableView)
        
//        tableView.snp.makeConstraints{
//            $0.top.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-20)
//        }
        view.addSubviews(textField)
        view.addSubviews(AddSubscriberBtn)
        view.addSubviews(label)
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        AddSubscriberBtn.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(30)
            make.centerX.equalTo(textField)
        }
        label.snp.makeConstraints{ make in
            make.top.equalTo(AddSubscriberBtn.snp.bottom).offset(10)
            make.centerX.equalTo(AddSubscriberBtn)
        }
        
    }
        
//    func showAlert(velogId:String){
//        let alert = UIAlertController(title: "Want to subscribe?", message: "will be added to the subscription list", preferredStyle: UIAlertController.Style.alert)
//
//        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil) // 여기에 클로저 형태로 이후 이벤트 구현
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in   // 여기에 클로저 형태로 이후 이벤트 구현
//            self.makeSubscribe(velogId: velogId)
//        })
//
//        alert.addAction(cancel)
//        alert.addAction(okAction)
//        present(alert, animated: true, completion: nil)
//    }
    
//    // showAlert에서의 okAction (구독 최종 추가 함수)
//    func makeSubscribe(velogId:String){
//        realm.add(item: velogId)
//    }
    
    
    @objc func checkVelogUser(){
        let id = self.textField.text ?? ""
        print(id)
        postServer(id: id)
    }
    
    // 검색 결과 확인
    func postServer(id:String){
        self.provider.request(.checkSubscriber(self.textField.text ?? "")){ response in
        switch response{
            case .success(let moyaResponse):
                do{
                    
                    print(try moyaResponse.mapJSON())
                    let responseData = try moyaResponse.map(AddSubscriberResponse.self)
                    
                    print(responseData.userName as Any)

                    if responseData.validate == true {
                        print("구독자 추가 성공!")
                        self.label.textColor = UIColor.black
                        self.label.text = "구독 추가 되었습니다."
                        // 최종 구독자 추가
                        self.addSubscriber(Id: id)
                    }else{
                        print("없는 사용자입니다.")
                        self.label.text = "없는 사용자입니다."
                        self.textField.text = ""
                    }
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 구독자 최종 추가
    func addSubscriber(Id:String){
        let param = AddRequest("temporaryFCMToken", Id)
        self.provider.request(.addSubscriber(param: param)){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    print("최종추가됨")
                    
                    self.getServer()
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 구독자 추가했을 경우 서버 디비 재호출
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    
    //
    //    var isFiltering: Bool {
    //        let searchController = self.navigationItem.searchController
    //        let isActive = searchController?.isActive ?? false
    //        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
    //        return isActive && isSearchBarHasText
    //    }

}

//extension SearchSubscribeViewController: UISearchBarDelegate{
//        private func dissmissKeyboard() {
////            self.searchBar.resignFirstResponder()
//            self.searchController.searchBar.resignFirstResponder()
//        }
//        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//            // 검색 시작
//            //키보드가 올라와 있을떄, 내려가게
//            dissmissKeyboard()
//            // 검색어가 있는지
//            guard let searchTerm = searchBar.text, searchTerm.isEmpty == false else { return }
//            print("--> 검색어: \(searchTerm)")
//
//        }
//
//}
//










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
//        searchController의 searchBar text를 Print -> 이렇게 Search Bar 업데이트를 볼 수 있다
//        dump(searchController.searchBar.text)
//        guard let text = searchController.searchBar.text?.lowercased() else { return }
//        print(text)
//        self.filteredArr = self.dummyData.filter { $0.localizedCaseInsensitiveContains(text) }
//        self.tableView.reloadData()

//        dump(filteredArr)
//    }
//}
