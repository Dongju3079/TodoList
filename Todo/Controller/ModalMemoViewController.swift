import UIKit
class ModalMemoVC: UIViewController {
    
    var selectedIndexPath: IndexPath?
    
    weak var delegate: MemoDelegate?
    
    let memoManager = MemoUserDatas.shared
    
    // 어떤 카테고리가 선택된지 알려주기 위해서
    var selectedCategory: String?
    
    let memoTextView: ModalMemoView = {
        let v = ModalMemoView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
        
    }()
    
    lazy var memoCategory: CategoryCollectionView = {
        let v = CategoryCollectionView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.plusButton.addTarget(self, action: #selector(categoryPlusButtonTapped), for: .touchUpInside)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(memoTextView)
        view.addSubview(memoCategory)
        SetupCollection()
        setupNaviBar()
        setupDatas()
    }
    
    func setupDatas() {
        memoManager.readCategory()
    }
    
    func setupNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let checkButton = UIBarButtonItem(title: "생성", style: .done, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = checkButton
    }
    
    @objc func plusButtonTapped() {
        let memo = MemoData(memoText: memoTextView.memoText.text, category: selectedCategory)
        memoManager.saveMemoList.append(memo)
        memoManager.saveMemoData()
        delegate?.tableViewUpdate()
        dismiss(animated: true)
    }
    
    
    func SetupCollection() {
        memoCategory.categoryCollection.dataSource = self
        memoCategory.categoryCollection.delegate = self
        memoCategory.categoryCollection.register(CategoryCellView.self, forCellWithReuseIdentifier: "CategoryCellView")
        memoCategory.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memoTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            memoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            memoTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            memoCategory.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            memoCategory.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            memoCategory.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            memoCategory.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc func categoryPlusButtonTapped() {
        let title = "카테고리를 작성해주세요."
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addTextField(){ (tf) in
            tf.placeholder = "카테고리 이름"
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let complete = UIAlertAction(title: "확인", style: .default) { (_)
            in // 확인버튼 누를 경우 취할 행동
            if let txt = alert.textFields?.first {
                
                guard txt.text?.isEmpty != true else {
                    let errorAlert = UIAlertController(title: "입력된 카테고리가 없습니다.", message: "1글자 이상 입력해주세요.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "확인", style: .default)
                    errorAlert.addAction(okAction)
                    self.present(errorAlert, animated: true)
                    return
                }
                
                for str in self.memoManager.categoryList {
                    if txt.text == str {
                        let errorAlert = UIAlertController(title: "중복된 카테고리가 있습니다.", message: nil, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "확인", style: .default)
                        errorAlert.addAction(okAction)
                        self.present(errorAlert, animated: true)
                        return
                    }
                }
                
                self.memoManager.categoryList.append(txt.text!)
                self.memoCategory.categoryCollection.reloadData()
                self.memoManager.saveCategory()
                
                // 🐝 추가된 항목이 들어간 셀의 IndexPath를 계산(배열.count는 1부터 시작, IndexPath의 순서는 0부터 시작)
                let lastItemIndexPath = IndexPath(item: self.memoManager.categoryList.count-1, section: 0)
                
                // 🐝 .scrollToItem 를 통해서 내가 원하는 셀로 이동할 수 있음
                self.memoCategory.categoryCollection.scrollToItem(at: lastItemIndexPath, at: .left, animated: true)
                
                
            } else {
                let errorAlert = UIAlertController(title: "입력된 카테고리가 없습니다.", message: "1글자 이상 입력해주세요.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "확인", style: .default)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true)
            }
        }
        alert.addAction(cancel)
        alert.addAction(complete)
        
        
        self.present(alert, animated: true)
        
    }
    
}

// MARK: - Collection

extension ModalMemoVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memoManager.categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCellView", for: indexPath) as! CategoryCellView
        
        cell.categoryText = memoManager.categoryList[indexPath.item]
        
        
        return cell
    }
    
    
}

extension ModalMemoVC: UICollectionViewDelegate {
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        selectedCategory = memoManager.categoryList[indexPath.item]
    //        var some = collectionView.visibleCells
    //        some.forEach { $0.contentView.layer.borderColor = UIColor.black.cgColor }
    ////        some.map { $0.contentView.layer.borderColor = UIColor.black.cgColor }
    //
    //        let test = collectionView.cellForItem(at: indexPath) as! CategoryCellView
    //        test.contentView.layer.borderColor = UIColor.red.cgColor
    //    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = memoManager.categoryList[indexPath.item]
        
        // 선택한 셀의 IndexPath를 업데이트
        selectedIndexPath = indexPath
        
        collectionView.reloadData() // reloadData로 모든 셀의 레이어 색 초기화
        collectionView.collectionViewLayout.invalidateLayout() // 레이아웃 갱신
    }
    
    // 셀이 컬렉션 뷰에 나타나기 전에 실행되는 함수
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let categoryCell = cell as? CategoryCellView {
            if indexPath == selectedIndexPath {
                // 선택한 셀에 대한 작업 수행
                categoryCell.contentView.layer.borderColor = UIColor.red.cgColor
            } else {
                // 나머지 셀에 대한 작업 수행
                categoryCell.contentView.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
}
