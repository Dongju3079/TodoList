//
//  TableViewCell.swift
//  Todo
//
//  Created by Macbook on 2023/08/27.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var isFirstCellInSection = false
    
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
    
    func configureRoundCorners(isOnlyCellInSection: Bool, isFirstInSection: Bool, isLastInSection: Bool) {
        // isOnlyCellInSection : 셀이 한개인 경우
        // isFirstInSection : 셀이 한개가 아닌 상태에서 첫번째 셀인 경우
        // isLastInSection : 셀이 한개가 아닌 상태에서 마지막 셀인 경우
        // else : 그 이외엔 모두 라운드처리(X)
        // 재사용셀 : else인 상태로 돌린다
        /* 문제, 헤맸던 부분 : 재사용셀의 self.layer.maskedCorners = [] 부분에서
             layer.maskedCorners는 빈 배열이 되는데 다시 채워주지 않고 Radius만 줬음 */
        if isOnlyCellInSection {
            self.clipsToBounds = true
            self.layer.cornerRadius = 18
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else if isFirstInSection {
            self.clipsToBounds = true
            self.layer.cornerRadius = 20
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if isLastInSection {
            self.clipsToBounds = true
            self.layer.cornerRadius = 20
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            self.clipsToBounds = false
            self.layer.cornerRadius = 0
            self.layer.maskedCorners = []
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("재사용")
        self.clipsToBounds = false
        self.layer.cornerRadius = 0
        self.layer.maskedCorners = []
    }
}

