//
//  CompletionViewController.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class CompletionViewController: UIViewController {

    let memoTable = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(memoTable)
        view.backgroundColor = MyColor.backColor
        setupNaviBar()

    }
    
    func setupNaviBar() {
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
