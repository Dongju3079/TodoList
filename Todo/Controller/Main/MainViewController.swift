import UIKit

class ViewController: UIViewController {
    
    let mainImageManager = Networking.shared
    
    let firstView = FirstView()
    
    var imageUrl: String? = "https://avatars.githubusercontent.com/u/131073398?v=4"
    
    let memoManager = MemoUserDatas.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = firstView
        setupTarget()
        setupImage()
        setupNaviBar()
        setupData()
        setupCatImage()
    }
    
    func setupNaviBar() {
        title = "ToDo List"
        
        // (네비게이션바 설정관련) iOS버전 업데이트 되면서 바뀐 설정⭐️⭐️⭐️
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()  // 불투명으로
      //  appearance.backgroundColor = .black // bartintcolor가 15버전부터 appearance로 설정하게끔 바뀜
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.shadowColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .orange
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupImage() {
        mainImageManager.fetchMusic(imageUrl: imageUrl!) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    self.firstView.mainImage.image = UIImage(data: imageData)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func setupData() {
        memoManager.readCategory()
        memoManager.readMemoData()
        memoManager.readCompleteMemoData()
    }
    
    func setupTarget() {
        firstView.todoButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
        firstView.completionButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
        firstView.profileButton.addTarget(self, action: #selector(moveAction), for: .touchUpInside)
    }
    
    @objc func moveAction(_ sender: UIButton) {
        if sender == firstView.todoButton {
            let memoView = MemoListViewController()
            navigationController?.pushViewController(memoView, animated: false)
        } else if sender == firstView.completionButton {
            let completionView = CompletionViewController()
            navigationController?.pushViewController(completionView, animated: false)
        } else {
            let profileView = ProfileViewController()
            let navController = UINavigationController(rootViewController: profileView)
            navController.modalPresentationStyle = .automatic
            present(navController, animated: true)
        }
    }
    
    func setupCatImage() {
        for i in 1...43 {
            MyProfilePhoto.photoList.append("\(i)")
        }
        print("\(MyProfilePhoto.photoList.count)")
    }
}
