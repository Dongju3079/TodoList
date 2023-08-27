//
//  CategoryCollectionView.swift
//  Todo
//
//  Created by Macbook on 2023/08/27.
//

import UIKit

class CategoryCollectionView: UIView {
    
    let categoryCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let collectionWidth = UIScreen.main.bounds.width - 130
        
        let itemSize = (collectionWidth - MyCategorie.spacingWitdh * (MyCategorie.cellColumns - 1)) / MyCategorie.cellColumns
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: itemSize, height: 40)
        flowLayout.minimumLineSpacing = MyCategorie.spacingWitdh
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        // 스크롤 바 없애기
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    let plusButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.setTitle("+", for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 25)
        b.setTitleColor(.black, for: .normal)
        
        b.backgroundColor = .white
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 8
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    lazy var sv: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [categoryCollection, plusButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sv)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            sv.leadingAnchor.constraint(equalTo: leadingAnchor),
            sv.trailingAnchor.constraint(equalTo: trailingAnchor),
            sv.topAnchor.constraint(equalTo: topAnchor),
            sv.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            categoryCollection.leadingAnchor.constraint(equalTo: sv.leadingAnchor),
            
            plusButton.trailingAnchor.constraint(equalTo: sv.trailingAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 25),
            
        ])
    }
    
}
