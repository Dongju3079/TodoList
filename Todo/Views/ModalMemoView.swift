//
//  ModalMemoView.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class ModalMemoView: UIView {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "memo5")) // 원하는 배경 이미지 이름으로 수정
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(memoView)
        
        // 🐝 UIImageView에 제스처를 추가 (UITextField를 imageview에 올리면 제스처가 중복되어 textview가 작동되지 않는 것 같음)
        // 그래서 imageview 제스처의 동작에 UITextField 키보드 동작을 추가
        
        // 🐝 UIImageView 어디를 터치해도 UITextField가 활성화되는 문제발생
        // UIImageView중 일부분의 좌표를 설정해서 해당 부분만 내가 원하는 메서드를 실행시키게 했음
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }()
    
    lazy var memoView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.clipsToBounds = true
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.black.cgColor
        v.addSubview(memoText)
        return v
    }()
    
    let memoText: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.textColor = .black
        t.tintColor = .darkGray

        // 대문자 안되게끔
        t.autocapitalizationType = .none
        t.spellCheckingType = .no
        t.autocorrectionType = .no
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundImage)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            memoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            memoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            memoView.heightAnchor.constraint(equalToConstant: 50),
            memoView.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 300),
            
            memoText.leadingAnchor.constraint(equalTo: memoView.leadingAnchor, constant: 5),
            memoText.trailingAnchor.constraint(equalTo: memoView.trailingAnchor, constant: -5),
            memoText.topAnchor.constraint(equalTo: memoView.topAnchor, constant: 5),
            memoText.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -5),
        ])
    }
    
    @objc func imageViewTapped(_ sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: backgroundImage)
        if touchPointIsInsideDesiredArea(touchPoint) {
            memoText.becomeFirstResponder()
        }
    }

    func touchPointIsInsideDesiredArea(_ point: CGPoint) -> Bool {
        let desiredAreaRect = CGRect(x: 100, y: 200, width: 200, height: 100)
        return desiredAreaRect.contains(point)
    }
    
}
