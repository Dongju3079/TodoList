//
//  FirstView.swift
//  Todo
//
//  Created by Macbook on 2023/08/25.
//

import UIKit

class FirstView: UIView {
    
    let mainImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        image.clipsToBounds = true
        image.layer.cornerRadius = 150
        return image
    }()
    
    let todoButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .clear

        bt.setTitleColor(.white, for: .normal)
        
        // 🐝 버튼에 bold효과 주기
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "ToDo List", attributes: attributes)
        bt.setAttributedTitle(attributedTitle, for: .normal)
        
        return bt
    }()
    
    let completionButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .clear

        bt.setTitleColor(.white, for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "Completion list", attributes: attributes)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(mainImage)
        self.addSubview(sv)
        autoLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            mainImage.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 300),
            mainImage.widthAnchor.constraint(equalToConstant: 300),
            mainImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            sv.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            sv.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            sv.heightAnchor.constraint(equalToConstant: 110),
            sv.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 50),
        ])
    }
    
    
    
    
}
