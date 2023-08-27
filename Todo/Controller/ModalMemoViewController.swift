import UIKit
class ModalMemoVC: UIViewController {
    
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
                
                self.memoManager.categoryList.insert(txt.text!, at: 0)
                self.memoCategory.categoryCollection.reloadData()
                self.memoManager.saveCategory()
                
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = memoManager.categoryList[indexPath.item]
    }
}
