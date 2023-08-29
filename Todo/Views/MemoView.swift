//
//  MemoView.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class MemoTableView: UIView {
    
    let memoTable: UITableView = {
        // style을 .grouped로 설정하지 않으면 헤더뷰가 따라오게 된다. (참고 : https://gyuios.tistory.com/159)
        let t = UITableView(frame: .zero, style: .grouped)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
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
