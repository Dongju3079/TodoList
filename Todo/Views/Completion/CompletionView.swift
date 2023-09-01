//
//  ModalMemoView.swift
//  Todo
//
//  Created by Macbook on 2023/08/26.
//

import UIKit

class ModalMemooView: UIView {
    
    
    var cellOfNumber: Int? {
        didSet {
//            categoryCollectionHeight()
        }
    }
    
    lazy var CategoryTitleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.borderColor = UIColor.black.cgColor
        
        v.addSubview(CategoryTitleLabel)
        return v
    }()
    
    let CategoryTitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .boldSystemFont(ofSize: 30)
        l.backgroundColor = .clear
        l.textAlignment = .left
        l.text = "Category"
        l.textColor = .white
        return l
    }()
    
    let categoryCollection: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        
        /* 🐝
         UIApplication.shared.connectedScenes : 현재 앱이 실행 중이 모든 씬(화면)의 배열
         windowScene.windows.first : 현재의 화면에서 첫번째 윈도우(창)
         */
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)}
        guard let window = windowScene.windows.first else {
            return UICollectionView(frame: .zero, collectionViewLayout: flowLayout)}
        
        let sheetWidth = window.safeAreaLayoutGuide.layoutFrame.width
        var itemSize = (sheetWidth - (40 + MyCategorie.spacingWidth * (MyCategorie.cellColumns - 1))) / MyCategorie.cellColumns
        
        flowLayout.itemSize = CGSize(width: itemSize, height: MyCategorie.cellHeight)
        flowLayout.minimumLineSpacing = MyCategorie.spacingWidth
        flowLayout.minimumInteritemSpacing = MyCategorie.spacingWidth
        flowLayout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .clear
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        // 스크롤 바 없애기
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    lazy var categoryHeight = categoryCollection.heightAnchor.constraint(greaterThanOrEqualToConstant: 44)
    
    
    lazy var todoTitleView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        v.layer.borderColor = UIColor.black.cgColor
        
        v.addSubview(todoTitleLabel)
        return v
    }()
    
    let todoTitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .boldSystemFont(ofSize: 30)
        l.backgroundColor = .blue
        l.textAlignment = .left
        l.text = "ToDo Tiasdstlgggge"
        l.textColor = .white
        return l
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
    
    let okAtion: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("확인", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 20)
        b.backgroundColor = .clear
        b.clipsToBounds = true
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    let cancleAtion: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("취소", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 20)
        b.backgroundColor = .clear
        b.clipsToBounds = true
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 2
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    lazy var buttonSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [cancleAtion, okAtion])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 20
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(CategoryTitleView)
        self.addSubview(categoryCollection)
        self.addSubview(todoTitleView)
        self.addSubview(memoView)
        self.addSubview(buttonSV)
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            
            CategoryTitleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            CategoryTitleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            CategoryTitleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            CategoryTitleView.heightAnchor.constraint(equalToConstant: 20),
            
            CategoryTitleLabel.leadingAnchor.constraint(equalTo: CategoryTitleView.leadingAnchor),
            CategoryTitleLabel.trailingAnchor.constraint(equalTo: CategoryTitleView.trailingAnchor),
            CategoryTitleLabel.centerYAnchor.constraint(equalTo: CategoryTitleView.centerYAnchor),
            
//            categoryCollection.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryCollection.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            categoryCollection.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            categoryCollection.topAnchor.constraint(equalTo: CategoryTitleView.bottomAnchor, constant: 10),
            categoryCollection.bottomAnchor.constraint(equalTo: todoTitleView.topAnchor),
            categoryHeight,
            
            todoTitleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            todoTitleView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            todoTitleView.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor),
            todoTitleView.heightAnchor.constraint(equalToConstant: 20),
            
            todoTitleLabel.leadingAnchor.constraint(equalTo: todoTitleView.leadingAnchor),
            todoTitleLabel.trailingAnchor.constraint(equalTo: todoTitleView.trailingAnchor),
            todoTitleLabel.centerYAnchor.constraint(equalTo: todoTitleView.centerYAnchor),
            
            memoView.topAnchor.constraint(equalTo: todoTitleView.bottomAnchor, constant: 10),
            memoView.leadingAnchor.constraint(equalTo: leadingAnchor),
            memoView.trailingAnchor.constraint(equalTo: trailingAnchor),
            memoView.heightAnchor.constraint(equalToConstant: 40),
            
            
            memoText.leadingAnchor.constraint(equalTo: memoView.leadingAnchor, constant: 5),
            memoText.trailingAnchor.constraint(equalTo: memoView.trailingAnchor, constant: -5),
            memoText.topAnchor.constraint(equalTo: memoView.topAnchor, constant: 5),
            memoText.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -5),
            
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonSV.topAnchor.constraint(equalTo: memoView.bottomAnchor, constant: 25),
            buttonSV.heightAnchor.constraint(equalToConstant: 40),
            
            
            okAtion.trailingAnchor.constraint(equalTo: buttonSV.trailingAnchor),
            okAtion.centerYAnchor.constraint(equalTo: buttonSV.centerYAnchor),
            
            cancleAtion.leadingAnchor.constraint(equalTo: buttonSV.leadingAnchor),
            cancleAtion.centerYAnchor.constraint(equalTo: buttonSV.centerYAnchor),
            okAtion.widthAnchor.constraint(equalToConstant: 40),
            cancleAtion.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func categoryCollectionHeight() {
        guard let cellOfNumber = cellOfNumber else { return }
        switch cellOfNumber {
        case 7...:
            categoryHeight.constant = MyCategorie.cellViewHighHeight
        case 4...:
            categoryHeight.constant = MyCategorie.cellViewMiddelHeight
        default:
            categoryHeight.constant = MyCategorie.cellViewLowHeight
        }
        
        // 🐝 컬렉션뷰의 크기를 즉시 변경하게 해주는 코드
        categoryCollection.layoutIfNeeded()
    }
}
