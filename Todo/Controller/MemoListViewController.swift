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
        view.backgroundColor = MyColor.backColor
        setupNaviBar()
        autoLayout()
        setupMemoTable()
    }
    
    
    // MARK: - Navigation
    
    func setupNaviBar() {
        title = "To Do List"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 추가버튼 생성하기
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
        // 🐝 네비게이션 표시하지 않기
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoManger.readMemoData()
        memoList.memoTable.reloadData()
    }
    
    @objc func plusButtonTapped() {
        let addMemoViewController = ModalMemoVC()
        let navigationController = UINavigationController(rootViewController: addMemoViewController)
        addMemoViewController.delegate = self
        present(navigationController, animated: true, completion: nil)
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
            memoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            memoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            memoList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            memoList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20)
        ])
    }
    
}
extension MemoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "t"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return memoManger.categoryList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categorySection = memoManger.categoryList[section]
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
        return categoryMemo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let categorySection = memoManger.categoryList[indexPath.section]
        let categoryMemo = memoManger.saveMemoList.filter { $0.category == categorySection }
        
        
        cell.myMemo = categoryMemo[indexPath.row].memoText
        
        print("section: \(indexPath.section) | row: \(indexPath.row)")
        print("\(categoryMemo.count)")

        if indexPath.row == 0 { // 섹션의 첫 번째 셀에 레이어 처리 적용
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [ .layerMaxXMinYCorner, .layerMinXMinYCorner ]
        } else if indexPath.row == categoryMemo.count-1 {
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner ]
        } else {
//            cell.clipsToBounds = false
        }
        
        
        return cell
    }
    
    
}
extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = TableViewHeaderView()
        sectionView.sectionCategory = memoManger.categoryList[section]
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30 // 헤더 뷰의 높이 설정
    }
}


extension MemoListViewController: MemoDelegate {
    func tableViewUpdate() {
        memoManger.readMemoData()
        DispatchQueue.main.async { [weak self] in
            self?.memoList.memoTable.reloadData()
        }
        
    }
}
