import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let firstView = FirstView()
    
    private let memoManager = MemoUserDatas.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = firstView
        view.backgroundColor = MyColor.backColor
        setupNaviBar()
        setupTarget()
    }
    
    // MARK: - Navigation 설정
    func setupNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 🐝 네비게이션 표시하지 않기
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupTarget() {
        firstView.todoButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
        firstView.completionButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
    }

    @objc func moveAction(_ sender: UIButton) {
        if sender == firstView.todoButton {
            let memoView = MemoListViewController()
            navigationController?.pushViewController(memoView, animated: true)
        } else {
            let completionView = CompletionViewController()
            navigationController?.pushViewController(completionView, animated: true)
        }
    }
}

