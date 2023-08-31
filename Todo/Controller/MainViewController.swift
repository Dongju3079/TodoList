import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let firstView: FirstView = {
        let v = FirstView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    private let memoManager = MemoUserDatas.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(firstView)
//        setupNaviBar()
        setupTarget()
        autoLayout()
    }
    
    // MARK: - Navigation 설정
//    func setupNaviBar() {
//        title = "To Do List"
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()  // 불투명으로
//        appearance.backgroundColor = .clear
//        navigationController?.navigationBar.tintColor = .systemBlue
//        navigationController?.navigationBar.standardAppearance = appearance
//        navigationController?.navigationBar.compactAppearance = appearance
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
//
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "검색"
//        searchController.searchResultsUpdater = self
//        // 검색상태에서 상태창 숨김기능
//        searchController.hidesNavigationBarDuringPresentation = false
//
//        // 검색상태에서 서치된 항목을 선택가능하게 할 것인지?
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.delegate = self
//
//        // 추가버튼 생성하기
//        navigationItem.searchController = searchController
//        // 🐝 네비게이션 표시하지 않기
//        navigationController?.isNavigationBarHidden = false
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
//    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            firstView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            firstView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            firstView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            firstView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupTarget() {
        firstView.todoButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
        firstView.completionButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
    }
    
    @objc func moveAction(_ sender: UIButton) {
        if sender == firstView.todoButton {
            let memoView = MemoListViewController()
            navigationController?.pushViewController(memoView, animated: false)
        } else {
            let completionView = CompletionViewController()
            navigationController?.pushViewController(completionView, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
