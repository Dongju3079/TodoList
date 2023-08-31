import UIKit
class ModalMemoVC: UIViewController {
    
    var selectedIndexPath: IndexPath?
    
    weak var delegate: MemoDelegate?
    
    let memoManager = MemoUserDatas.shared
    
    // 어떤 카테고리가 선택된지 알려주기 위해서
    var selectedCategory: String?
    
    lazy var memoTextView: ModalMemoView = {
        let v = ModalMemoView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.okAtion.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        v.cancleAtion.addTarget(self, action: #selector(cancleButtonTapped), for: .touchUpInside)
        return v
        
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.memoTextView.categoryCollectionHeight()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(memoTextView)
        view.backgroundColor = UIColor(red: 0.06, green: 0.06, blue: 0.06, alpha: 1.00)
        SetupCollection()
        setupNaviBar()
        setupDatas()
    }
    
    func setupDatas() {
        memoManager.readCategory()
        memoTextView.cellOfNumber = memoManager.categoryList.count
    }
    
    func setupNaviBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
        appearance.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let checkButton = UIBarButtonItem(title: "생성", style: .done, target: self, action: #selector(plusButtonTapped))
        navigationItem.rightBarButtonItem = checkButton
    }
    
    @objc func cancleButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func plusButtonTapped() {
        self.memoTextView.memoText.resignFirstResponder()
        if selectedCategory != nil && memoTextView.memoText.text != "" {
            let memo = MemoData(memoText: memoTextView.memoText.text, category: selectedCategory, date: Date())
            memoManager.saveMemoList.append(memo)
            memoManager.saveMemoData()
            
            // 카테고리에 해당하는 함수 필터링
            let memos = memoManager.saveMemoList.filter { $0.category == selectedCategory }
            // 카테고리가 몇번째인지 알려주는
            let locationSection = memoManager.categoryList.firstIndex(of: memo.category!)!
            if let locationItem = memos.firstIndex(where: {$0 == memo}) {
                delegate?.tableViewUpdate(section: locationSection, item: locationItem)
            } else {
                print("tt")
            }

            dismiss(animated: true)
        } else {
            let errorAlert = UIAlertController(title: "카테고리 또는 메모를 \n 입력해주세요.", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            errorAlert.addAction(okAction)
            self.present(errorAlert, animated: true)
            return
        }
    }
    
    
    func SetupCollection() {
        memoTextView.categoryCollection.dataSource = self
        memoTextView.categoryCollection.delegate = self
        memoTextView.categoryCollection.register(CategoryCellView.self, forCellWithReuseIdentifier: "CategoryCellView")
        
        NSLayoutConstraint.activate([
            memoTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            memoTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            memoTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            memoTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
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
        if memoManager.categoryList.count-1 == indexPath.item {
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
                    
                    self.memoManager.categoryList.insert(txt.text!, at: self.memoManager.categoryList.endIndex-1)
                    self.memoTextView.categoryCollection.reloadData()
                    self.memoManager.saveCategory()
                    
                    self.memoTextView.cellOfNumber = self.memoManager.categoryList.count
                    
                    // 🐝 추가된 항목이 들어간 셀의 IndexPath를 계산(배열.count는 1부터 시작, IndexPath의 순서는 0부터 시작)
                    let lastItemIndexPath = IndexPath(item: self.memoManager.categoryList.count-1, section: 0)
                    
                    // 🐝 .scrollToItem 를 통해서 내가 원하는 셀로 이동할 수 있음
                    self.memoTextView.categoryCollection.scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
                    
                    
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
        } else { selectedCategory = memoManager.categoryList[indexPath.item] }
    }
}
