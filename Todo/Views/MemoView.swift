//
//  MemoView.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class MemoTableView: UIView {
    
    let memoTable: UITableView = {
        /* 🐝
          style을 .grouped로 설정하지 않으면 헤더뷰가 따라오게 된다. (참고 : https://gyuios.tistory.com/159)
          t.sectionFooterHeight = 0 를 해주지 않으면 기본 FooterHeight가 생기면서 공간이 벌어진다.
         */
        
        let t = UITableView(frame: .zero, style: .grouped)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.indicatorStyle = .white
        t.separatorStyle = .none
        t.sectionFooterHeight = 0
        
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(memoTable)
        self.backgroundColor = .black
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            memoTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            memoTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            memoTable.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -20),
            memoTable.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            memoTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
    
}

