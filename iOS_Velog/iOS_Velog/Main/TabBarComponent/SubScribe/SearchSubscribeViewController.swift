//
//  SearchSubscribeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit
import SnapKit
import Then

class SearchSubscribeViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)
    
//    let alert = UIAlertController(title: "Want to subscribe?", message: "will be added to the subscription list", preferredStyle: UIAlertController.Style.alert)
//
////    let okAction = UIAlertAction(title: "OK", style: .default) { action in
////        // add button event
////    }
//    let cancel = UIAlertAction(title: "cancel", style: .cancel, handler : nil)
//    let okAction = UIAlertAction(title: "OK", style: .default,handler: nil)



    
    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    var dummyData = ["Aaliyah","Aaron","Olivia","Hazel","Lily","Zoe","Grace","Ava","Isabella","Harry","Liam","Lucas","Declan","Elliot","Owen","Theodore","Jasper","Oskar","Tyler","Jade","Cameron","Kailani","Rochella","Floriana","Melody","Agata","Mia"]
    
    // fillerArr
    var filteredArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupTableView()
//        self.setAlert()
        // UI
        setUI()
    }
//
//    func setAlert(){
//        alert.addAction(cancel)
//        alert.addAction(okAction)
//    }
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
        searchController.searchResultsUpdater = self
        
        // keyboard up -> not finish
//        searchController.becomeFirstResponder()
    }
    
    func setupTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Want to subscribe?", message: "will be added to the subscription list", preferredStyle: UIAlertController.Style.alert)
    //    let okAction = UIAlertAction(title: "OK", style: .default) { action in
    //        // add button event
    //    }
        let cancel = UIAlertAction(title: "cancel", style: .destructive, handler : nil)
        let okAction = UIAlertAction(title: "OK", style: .default,handler: nil)
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

extension SearchSubscribeViewController:UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dummyData.count
        return self.isFiltering ? self.filteredArr.count : self.dummyData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        
        if self.isFiltering {
        cell.textLabel?.text = self.filteredArr[indexPath.row]
        } else {
            cell.textLabel?.text = self.dummyData[indexPath.row]
        }
        return cell
    }
    
    // cell 클릭 시 생기는 alert
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        present(alert, animated: false, completion: nil)
        showAlert()
        print("cell touched")
    }
    


}

extension SearchSubscribeViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        searchController의 searchBar text를 Print -> 이렇게 Search Bar 업데이트를 볼 수 있다
        dump(searchController.searchBar.text)
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.dummyData.filter { $0.localizedCaseInsensitiveContains(text) }
        self.tableView.reloadData()
        
        dump(filteredArr)
    }
}


