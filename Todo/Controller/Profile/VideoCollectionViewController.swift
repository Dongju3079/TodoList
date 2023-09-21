//
//  DefaultCollectionViewController.swift
//  Todo
//
//  Created by Macbook on 2023/09/20.
//

import UIKit

class VideoCollectionViewController: UIViewController {
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        let itemSize = (UIScreen.main.bounds.width - MyProfilePhoto.spacingWidth * (MyProfilePhoto.cellColumns - 1)) / MyProfilePhoto.cellColumns
        
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        flowLayout.minimumLineSpacing = MyProfilePhoto.spacingWidth
        flowLayout.minimumInteritemSpacing = MyProfilePhoto.spacingWidth
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.bounces = false

        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autoLayout()
    }
    
    func autoLayout() {
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .clear
        
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCollectionCell")

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension VideoCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MyProfilePhoto.photoList1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionCell", for: indexPath) as! PhotoCollectionCell
        
        cell.categoryText = MyProfilePhoto.photoList1[indexPath.item]
        
        return cell
    }
}
