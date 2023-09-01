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
        view = memoTable
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        
    }
    
    
    
    
}
