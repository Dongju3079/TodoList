//
//  TableViewHeaderView.swift
//  Todo
//
//  Created by Macbook on 2023/08/28.
//

import UIKit

class TableViewHeaderView: UIView {
    
    var sectionCategory: String? {
        didSet {
            headerLabel.text = sectionCategory
        }
    }
    
    lazy var headerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.borderColor = UIColor.black.cgColor

        v.addSubview(headerLabel)
        return v
    }()
    
    let headerLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .boldSystemFont(ofSize: 30)
        l.backgroundColor = .clear
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerView)
        self.backgroundColor = .clear
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 20),
            headerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 25),
            
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

        ])
    }
    
}

