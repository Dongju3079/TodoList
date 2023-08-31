//
//  MemoListViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class MemoListViewController: UIViewController {
    
    let memoManger = MemoUserDatas.shared
    
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
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .black // bartintcolor가 15버전부터 appearance로 설정하게끔 바뀜
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.orange]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        let addButtonTwo = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonTapped))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.searchController = searchController
        
        navigationItem.leftBarButtonItem = addButtonTwo
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoManger.readMemoData()
        memoList.memoTable.reloadData()
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
            sheet.delegate = self
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
        memoManger.readCategory()
        memoManger.readMemoData()
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

extension MemoListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoManger.categoryList.count // 3개의 섹션
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categorySection = memoManger.categoryList[section]
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
        return categoryMemo.count // 1번째 섹션 갯수(4), 2번째 섹션 갯수(1), 3번째 섹션 갯수(1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1번째 섹션( 1, 2, 3, 4)
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let categorySection = memoManger.categoryList[indexPath.section]
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
        
        cell.myMemo = categoryMemo[indexPath.row].memoText

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
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
        if categoryMemo.isEmpty != true {
            sectionView.sectionCategory = categorySection
            print("헤더뷰추가")
            return sectionView
            
        } else { return nil }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let categorySection = memoManger.categoryList[section]
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
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
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
        if let myCell = cell as? TableViewCell {
            if indexPath.row == categoryMemo.count - 1 {
                myCell.separatorView.isHidden = true
            } else {
                myCell.separatorView.isHidden = false
            }
        }
    }
}


extension MemoListViewController: MemoDelegate {
    
    func tableViewUpdate(section: Int) {
        memoManger.readMemoData()
        memoList.memoTable.reloadData()
        
        // 🐝 추가된 항목이 들어간 셀의 IndexPath를 계산(배열.count는 1부터 시작, IndexPath의 순서는 0부터 시작)
        let addMemoIndexPath = IndexPath(item: 0, section: section)
        
        // 🐝 .scrollToItem 를 통해서 내가 원하는 셀로 이동할 수 있음
        self.memoList.memoTable.scrollToRow(at: addMemoIndexPath, at: .middle, animated: true)
    }
}

extension MemoListViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        //크기 변경 됐을 경우
        print(sheetPresentationController.selectedDetentIdentifier == .large ? "large" : "medium")
    }
}

extension MemoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension MemoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("1")
        self.view.endEditing(true)
    }
}
