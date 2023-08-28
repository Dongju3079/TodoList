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
        t.backgroundColor = .clear
        t.font = .boldSystemFont(ofSize: 20)
        t.textColor = .black
        return t
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(myText)
        self.backgroundColor = .orange
        autoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            myText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5),
            myText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            myText.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
