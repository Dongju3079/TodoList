//
//  TableViewCell.swift
//  Todo
//
//  Created by Macbook on 2023/08/27.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var isLastCellInSection = false
    
    var myMemo: String? {
        didSet {
            myText.text = myMemo
        }
    }
    
    // 🐝 구분선을 만들고 싶을 땐 uiview를 활용해서 선을 만들자 (구분선을 넣을 조건이 필요하다면 tableView의 확장인 willDisplay에 조건을 넣어주도록 하자) ‼️ 알아볼 것 willDisplay 시점
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var myMemoView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .darkGray
        v.addSubview(memoSV)
        return v
    }()
    
    let myText: UILabel = {
        let t = UILabel()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.font = .boldSystemFont(ofSize: 20)
        t.textColor = .white
        t.backgroundColor = .clear
        t.numberOfLines = 1
        return t
    }()
    
    let dateLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .clear
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 10)
        l.text = "2023-08-29"
        return l
    }()
    
    lazy var sv: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [myText, dateLabel])
        sv.translatesAutoresizingMaskIntoConstraints =  false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    let timeLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = true
        l.backgroundColor = .clear
        l.textColor = .white
        l.font = .boldSystemFont(ofSize: 25)
        l.text = "00:00:00"
        l.textAlignment = .right
        return l
    }()
    
    lazy var memoSV: UIStackView = {
       let sv = UIStackView(arrangedSubviews: [sv, timeLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        // 🐝 ‼️ (매우 중요) 셀에서는 self.addSubvie가 아닌 self.contentView에 추가해야 한다. ‼️
        self.contentView.addSubview(myMemoView)
        self.contentView.addSubview(separatorView)
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
     
        autoLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        myText.setContentHuggingPriority(.defaultLow, for: .vertical)
        dateLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            myMemoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myMemoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myMemoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myMemoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            memoSV.leadingAnchor.constraint(equalTo: myMemoView.leadingAnchor, constant: 10),
            memoSV.trailingAnchor.constraint(equalTo: myMemoView.trailingAnchor, constant: -10),
            memoSV.topAnchor.constraint(equalTo: myMemoView.topAnchor, constant: 10),
            memoSV.bottomAnchor.constraint(equalTo: myMemoView.bottomAnchor, constant: -10),
            
            myText.leadingAnchor.constraint(equalTo: sv.leadingAnchor),
            myText.topAnchor.constraint(equalTo: sv.topAnchor),
            
            dateLabel.leadingAnchor.constraint(equalTo: sv.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: sv.bottomAnchor),
            
            timeLabel.trailingAnchor.constraint(equalTo: memoSV.trailingAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: memoSV.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: memoSV.topAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: myMemoView.leadingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    // 🐝 테이블뷰와 컨텐츠뷰
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let horizontalSpacing: CGFloat = 20 // 좌우 간격
        let verticalSpacing: CGFloat = 0    // 상하 간격
        
        // 셀의 컨텐츠 뷰 프레임을 가져옵니다.
        var contentViewFrame = contentView.frame
        
        // 각종 간격을 적용합니다.
        contentViewFrame.origin.x += horizontalSpacing
        contentViewFrame.size.width -= horizontalSpacing * 2 // 양쪽으로 동일한 간격을 적용
        contentViewFrame.origin.y += verticalSpacing
        contentViewFrame.size.height -= verticalSpacing * 2 // 상하로 동일한 간격을 적용
        
        // 컨텐츠 뷰의 프레임을 조정합니다.
        contentView.frame = contentViewFrame
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
            self.myMemoView.clipsToBounds = true
            self.myMemoView.layer.cornerRadius = 18
            self.myMemoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
        } else if isFirstInSection {
            self.myMemoView.clipsToBounds = true
            self.myMemoView.layer.cornerRadius = 20
            self.myMemoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else if isLastInSection {
            self.myMemoView.clipsToBounds = true
            self.myMemoView.layer.cornerRadius = 20
            self.myMemoView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            self.myMemoView.clipsToBounds = false
            self.myMemoView.layer.cornerRadius = 0
            self.myMemoView.layer.maskedCorners = []
        }
    }
}

