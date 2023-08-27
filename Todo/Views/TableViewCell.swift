//
//  TableViewCell.swift
//  Todo
//
//  Created by Macbook on 2023/08/27.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var myMemo: String? {
        didSet {
            myText.text = myMemo
        }
    }
    
    let myText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .gray
        t.textColor = .black
        return t
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(myText)
        autoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            myText.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            myText.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            myText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            myText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    
}
