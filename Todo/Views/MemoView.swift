//
//  MemoView.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class MemoTableView: UIView {
    
    let memoTable: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.clipsToBounds = true
        t.layer.cornerRadius = 10
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(memoTable)
        self.backgroundColor = .clear
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            memoTable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            memoTable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            memoTable.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            memoTable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
    }
    
}
