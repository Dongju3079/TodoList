//
//  MemoListViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class MemoListViewController: UIViewController {
    
    let memoManger = MemoUserDatas.shared
    
    let memoTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(memoTable)
        view.backgroundColor = MyColor.backColor
        setupNaviBar()
        setupMemoTable()
        memoManger.readMemoData()
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
        memoTable.reloadData()
    }
    
    
    @objc func plusButtonTapped() {
        let addMemoViewController = ModalMemoVC()
        let navigationController = UINavigationController(rootViewController: addMemoViewController)
        addMemoViewController.delegate = self
        present(navigationController, animated: true, completion: nil)
    }
    
    // 네비게이션 버튼 설정 (+ 추가 및 얼럿창 생성)
    
    // 테이블 뷰 셋팅
    func setupMemoTable() {
        memoTable.dataSource = self
        memoTable.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        memoTable.backgroundColor = MyColor.backColor
        memoTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            memoTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            memoTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            memoTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memoTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
}
extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoManger.saveMemoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.myMemo = memoManger.saveMemoList[indexPath.row].memoText
        
        return cell
    }
    
    
}

extension MemoListViewController: MemoDelegate {
    func tableViewUpdate() {
        memoManger.readMemoData()
        memoTable.reloadData()
    }
}
