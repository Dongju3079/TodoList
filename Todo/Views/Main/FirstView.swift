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
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear

        button.setTitleColor(.black, for: .normal)
        
        // 🐝 버튼에 bold효과 주기
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "ToDo List", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    let completionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear

        button.setTitleColor(.black, for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "Completion list", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)

        return button
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear

        button.setTitleColor(.black, for: .normal)
        
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 30)]
        let attributedTitle = NSAttributedString(string: "My Profile", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)

        return button
    }()
    
    lazy var sv: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [todoButton, completionButton, profileButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 20
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
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
            sv.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 50),
        ])
    }
    
    
    
    
}
