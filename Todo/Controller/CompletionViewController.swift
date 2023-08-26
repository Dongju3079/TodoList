//
//  CompletionViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class CompletionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupNaviBar()

    }
    
    func setupNaviBar() {
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 🐝 네비게이션 표시하지 않기
        navigationController?.isNavigationBarHidden = false
    }
    



}
