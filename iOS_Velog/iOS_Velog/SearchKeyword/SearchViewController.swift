//
//  SearchViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//


import UIKit
import SnapKit
import Then

class SearchViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: nil)

    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    var dummyData = ["홍대 핵인싸 인영~~", "Alan Walker", "David Guetta", "Avicii", "Marshmello", "Steve Aoki", "R3HAB", "Armin van Buuren", "Skrillex", "Illenium", "The Chainsmokers", "Don Diablo", "Afrojack", "Tiesto", "KSHMR", "DJ Snake", "Kygo", "Galantis", "Major Lazer", "Vicetone","hong","Kang","King","Kun","Han","amerd"]
    
    // fillerArr
    var filteredArr: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchController()
        self.setupTableView()
        
        // UI
        setUI()
    }

    func setupSearchController(){
        // Do any additional setup after loading the view.
        navigationItem.title = "Keyword Search"
                
        // navigation item 에 searchController 추가
        navigationItem.searchController = searchController
        self.navigationController?.navigationBar.prefersLargeTitles = true
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.automaticallyShowsCancelButton = false

        // text 입력할 때 마다 업데이트 될 부분
        searchController.searchResultsUpdater = self
        
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
}

extension SearchViewController:UITableViewDelegate, UITableViewDataSource{
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
}

extension SearchViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        searchController의 searchBar text를 Print -> 이렇게 Search Bar 업데이트를 볼 수 있다
        dump(searchController.searchBar.text)
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        self.filteredArr = self.dummyData.filter { $0.localizedCaseInsensitiveContains(text) }
        self.tableView.reloadData()
        dump(filteredArr)
    }
}
