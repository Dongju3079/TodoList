//
//  FirstView.swift
//  Todo
//
//  Created by Macbook on 2023/08/25.
//

import UIKit

class FirstView: UIView {
    
    let mainImage: UIView = {
        let image = UIView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        
        return image
    }()
    
    let todoButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .darkGray

        bt.setTitleColor(.black, for: .normal)
        
        // 🐝 버튼에 bold효과 주기
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "To Do", attributes: attributes)
        bt.setAttributedTitle(attributedTitle, for: .normal)
        
        return bt
    }()
    
    let completionButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .darkGray

        bt.setTitleColor(.black, for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "Completion", attributes: attributes)
        bt.setAttributedTitle(attributedTitle, for: .normal)

        return bt
    }()
    
    lazy var sv: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [todoButton, completionButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 10
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    let RefreshButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .clear
        bt.setImage(UIImage(systemName: "arrow.clockwise.heart"), for: .normal)
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(mainImage)
        self.addSubview(sv)
        self.addSubview(RefreshButton)
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            mainImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            mainImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            mainImage.heightAnchor.constraint(equalToConstant: 200),
            mainImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            sv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            sv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            sv.heightAnchor.constraint(equalToConstant: 110),
            sv.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
          
            RefreshButton.topAnchor.constraint(equalTo: sv.bottomAnchor, constant: 50),
            RefreshButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            
        ])
    }
    
    
    
    
}
