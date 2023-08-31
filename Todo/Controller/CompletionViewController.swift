//
//  CompletionViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class CompletionViewController: UIViewController {
    
    let memoTable = UITableView()
    let testtt = ModalMemooView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(memoTable)
        view.backgroundColor = MyColor.backColor
        view = testtt
        setupNaviBar()
        
    }
    
    func setupNaviBar() {
        title = "김밥"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.backgroundColor = .blue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.barTintColor = .green
        

        
        // 추가버튼 생성하기

        navigationItem.searchController = searchController
        
    }
    
    
    
    
}
