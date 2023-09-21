//
//  MemoListViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class MemoListViewController: UIViewController {
    
    let memoManger = MemoUserDatas.shared
    
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
        setupNaviBar()
        autoLayout()
        setupMemoTable()
    }
    
    // MARK: - Navigation
    
    func setupNaviBar() {
        title = "ToDo List"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationController?.navigationBar.shadowImage = UIImage()

        let addButtonTwo = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonTapped))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = addButtonTwo
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func plusButtonTapped() {
        let addMemoViewController = ModalMemoVC()
        addMemoViewController.delegate = self
        addMemoViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = addMemoViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            
            sheet.prefersGrabberVisible = true
        }
        
        present(addMemoViewController, animated: true, completion: nil)
    }
    
    // 테이블 뷰 셋팅
    func setupMemoTable() {
        memoList.memoTable.dataSource = self
        memoList.memoTable.delegate = self
        /*
         🐝 xcode(14버전), 시뮬레이터(16.4버전)
         15버전 이상부터는 테이블뷰와 섹션헤더간의 패딩이 기본값으로 존재한다.
         14버전으로 개발을 하니 패딩을 조절할 방법이 없었고 (시뮬레이터도 14버전이였다면 관계없음)
         시뮬레이터는 16.4 버전으로 기본 패딩이 존재한 상태로 표시가 된다.
         */
        memoList.memoTable.sectionHeaderTopPadding = 0 //상단 여백 해결
        memoList.memoTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            memoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            memoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            memoList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memoList.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension MemoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoManger.categoryList.count // 3개의 섹션
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categorySection = memoManger.categoryList[section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManger.saveMemoList.filter { $0.category == categorySection }
        return categoryMemo.count // 1번째 섹션 갯수(4), 2번째 섹션 갯수(1), 3번째 섹션 갯수(1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1번째 섹션( 1, 2, 3, 4)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let categorySection = memoManger.categoryList[indexPath.section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManger.saveMemoList.filter { $0.category == categorySection }
        
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

extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = TableViewHeaderView()
        let categorySection = memoManger.categoryList[section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManger.saveMemoList.filter { $0.category == categorySection }
        if categoryMemo.isEmpty != true {
            sectionView.sectionCategory = categorySection
            print("헤더뷰추가")
            return sectionView
            
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let categorySection = memoManger.categoryList[section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManger.saveMemoList.filter { $0.category == categorySection }
        if categoryMemo.isEmpty != true {
            return 50
        } else { return 0 }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // 셀 구분선 추가하기
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let categorySection = memoManger.categoryList[indexPath.section]
        let categoryMemo = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManger.saveMemoList.filter { $0.category == categorySection }
        if let myCell = cell as? TableViewCell {
            if indexPath.row == categoryMemo.count - 1 {
                myCell.separatorView.isHidden = true
            } else {
                myCell.separatorView.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addMemoViewController = StopWatchViewController()
        
        let categorySection = memoManger.categoryList[indexPath.section]
        let memos = isEditMode ?
        searchResult.filter { $0.category == categorySection } : memoManger.saveMemoList.filter { $0.category == categorySection }
        let selectedMemo = memos[indexPath.row]
        guard let memo = memoManger.saveMemoList.firstIndex(of: selectedMemo) else { return }
        
        addMemoViewController.delegate = self
        addMemoViewController.memo = selectedMemo
        addMemoViewController.memoIndex = memo
        addMemoViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = addMemoViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.delegate = self
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            
            sheet.prefersGrabberVisible = true
        }
        
        present(addMemoViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completionAction = UIContextualAction(style: .normal, title: "Finish") { [weak self] (action, view, completionHandler) in
            guard let weakself = self else { return }
            let categorySection = weakself.memoManger.categoryList[indexPath.section]
            let memos = weakself.isEditMode ?
            weakself.searchResult.filter { $0.category == categorySection } : weakself.memoManger.saveMemoList.filter { $0.category == categorySection }
            let selectedMemo = memos[indexPath.row]
            if weakself.isEditMode {
                guard let resultMemo = weakself.searchResult.firstIndex(of: selectedMemo) else { return }
                weakself.searchResult.remove(at: resultMemo)
            }
            
            guard let memo = weakself.memoManger.saveMemoList.firstIndex(of: selectedMemo) else { return }
            weakself.memoManger.completeData(memo: selectedMemo, index: memo)
            weakself.memoList.memoTable.reloadData()
            
            
            
        }
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let weakself = self else { return }
            let categorySection = weakself.memoManger.categoryList[indexPath.section]
            let memos = weakself.isEditMode ?
            weakself.searchResult.filter { $0.category == categorySection } : weakself.memoManger.saveMemoList.filter { $0.category == categorySection }
            let selectedMemo = memos[indexPath.row]
            if weakself.isEditMode {
                guard let resultMemo = weakself.searchResult.firstIndex(of: selectedMemo) else { return }
                weakself.searchResult.remove(at: resultMemo)
            }
            
            guard let memo = weakself.memoManger.saveMemoList.firstIndex(of: selectedMemo) else { return }
            weakself.memoManger.deleteData(memo: selectedMemo, index: memo)
            weakself.memoList.memoTable.reloadData()
        }
        
        
        
        completionAction.image = UIImage(systemName: "checkmark.circle")
        deleteAction.image = UIImage(systemName: "trash.circle")
        
        let configuration = UISwipeActionsConfiguration(actions: [completionAction, deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}



extension MemoListViewController: MemoDelegate {
    
    func tableViewUpdate(section: Int, item: Int) {
        memoManger.readMemoData()
        memoList.memoTable.reloadData()
        
        // 🐝 추가된 항목이 들어간 셀의 IndexPath를 계산(배열.count는 1부터 시작, IndexPath의 순서는 0부터 시작)
        let addMemoIndexPath = IndexPath(item: item, section: section)
        
        // 🐝 .scrollToItem 를 통해서 내가 원하는 셀로 이동할 수 있음
        self.memoList.memoTable.scrollToRow(at: addMemoIndexPath, at: .middle, animated: true)
    }
    
    
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let resultText = searchController.searchBar.text else { return }
        searchResult = memoManger.saveMemoList.filter{ $0.memoText?.contains(resultText) ?? false}
        memoList.memoTable.reloadData()
        
    }
}

extension MemoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}

extension MemoListViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print("test")
        self.memoList.memoTable.reloadData()
    }
}

extension MemoListViewController: WatchDelegate {
    
    func tableViewUpdate() {
        print("테스트")
        self.memoList.memoTable.reloadData()
    }
}




