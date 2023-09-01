//
//  CompletionViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class CompletionViewController: UIViewController {
    
    
    let memoManager = MemoUserDatas.shared
    
    var searchResult: [MemoData] = []
    
    var isEditMode: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    let memoList: MemoTableView = {
        let t = MemoTableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(memoList)
        view.backgroundColor = .black
        setupNaviBar()
        autoLayout()
        setupMemoTable()
    }
    
    func setupMemoTable() {
        memoList.memoTable.dataSource = self
        memoList.memoTable.delegate = self
        memoList.memoTable.sectionHeaderTopPadding = 0 //상단 여백 해결
        memoList.memoTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func setupNaviBar() {
        title = "Complete List"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        let addButtonTwo = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = addButtonTwo
    }
    
    override func viewWillAppear(_ animated: Bool) {        
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            memoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            memoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            memoList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memoList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CompletionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoManager.categoryList.count // 3개의 섹션
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categorySection = memoManager.categoryList[section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManager.completeList.filter { $0.category == categorySection }
        return categoryMemo.count // 1번째 섹션 갯수(4), 2번째 섹션 갯수(1), 3번째 섹션 갯수(1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1번째 섹션( 1, 2, 3, 4)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let categorySection = memoManager.categoryList[indexPath.section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManager.completeList.filter { $0.category == categorySection }
        
        cell.myMemo = categoryMemo[indexPath.row]
        
        cell.isLastCellInSection = indexPath.row != categoryMemo.count - 1
        let isOnlyCellInSection = categoryMemo.count == 1
        
        cell.configureRoundCorners(
            isOnlyCellInSection: isOnlyCellInSection,
            isFirstInSection: indexPath.row == 0,
            isLastInSection: indexPath.row == categoryMemo.count - 1)
        return cell
    }
}

extension CompletionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = TableViewHeaderView()
        let categorySection = memoManager.categoryList[section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManager.completeList.filter { $0.category == categorySection }
        if categoryMemo.isEmpty != true {
            sectionView.sectionCategory = categorySection
            print("헤더뷰추가")
            return sectionView
            
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let categorySection = memoManager.categoryList[section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManager.completeList.filter { $0.category == categorySection }
        if categoryMemo.isEmpty != true {
            return 50
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // 셀 구분선 추가하기
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let categorySection = memoManager.categoryList[indexPath.section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManager.completeList.filter { $0.category == categorySection }
        if let myCell = cell as? TableViewCell {
            if indexPath.row == categoryMemo.count - 1 {
                myCell.separatorView.isHidden = true
            } else {
                myCell.separatorView.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let weakself = self else { return }
            let categorySection = weakself.memoManager.categoryList[indexPath.section]
            let memos = weakself.isEditMode ?
            weakself.searchResult.filter { $0.category == categorySection } : weakself.memoManager.completeList.filter { $0.category == categorySection }
            let selectedMemo = memos[indexPath.row]
            if weakself.isEditMode {
                guard let resultMemo = weakself.searchResult.firstIndex(of: selectedMemo) else { return }
                weakself.searchResult.remove(at: resultMemo)
            }
            
            guard let memo = weakself.memoManager.completeList.firstIndex(of: selectedMemo) else { return }
            weakself.memoManager.deleteCompleteData(memo: selectedMemo, index: memo)
            weakself.memoList.memoTable.reloadData()
        }
        
        deleteAction.image = UIImage(systemName: "trash.circle")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

}


extension CompletionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let resultText = searchController.searchBar.text else { return }
        searchResult = memoManager.completeList.filter{ $0.memoText?.contains(resultText) ?? false}
        memoList.memoTable.reloadData()
        
    }
}

extension CompletionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
