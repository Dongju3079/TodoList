import UIKit

class ProfileViewController: UIViewController {
    
    let profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let defaultCollection = DefaultCollectionViewController()
    let videoCollection = VideoCollectionViewController()
    let tagCollection = TagCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(profileView)
        
        setupNaviBar()
        setConstraint()
        setProfileView()
        setupAction()
    }
    
    func setupNaviBar() {
        title = "My Profile"
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.shadowColor = .clear
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "editMenu"), style: .done, target: self, action: #selector(editButtonTapped))
        menuButton.tintColor = .black
        navigationItem.rightBarButtonItem = menuButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func editButtonTapped() {
        print("버튼눌림")
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        profileView.photoScrollView.delegate = self
    }
    
    func setProfileView() {
        addChild(defaultCollection)
        self.profileView.photoScrollView.addSubview(defaultCollection.view)
        defaultCollection.didMove(toParent: self)
        
        addChild(videoCollection)
        self.profileView.photoScrollView.addSubview(videoCollection.view)
        videoCollection.didMove(toParent: self)
        
        addChild(tagCollection)
        self.profileView.photoScrollView.addSubview(tagCollection.view)
        tagCollection.didMove(toParent: self)
        
        defaultCollection.view.translatesAutoresizingMaskIntoConstraints = false
        videoCollection.view.translatesAutoresizingMaskIntoConstraints = false
        tagCollection.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            defaultCollection.view.leadingAnchor.constraint(equalTo: profileView.photoScrollView.leadingAnchor),
            defaultCollection.view.topAnchor.constraint(equalTo: profileView.photoScrollView.topAnchor),
            defaultCollection.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            defaultCollection.view.heightAnchor.constraint(equalTo: profileView.photoScrollView.heightAnchor),
            
            videoCollection.view.leadingAnchor.constraint(equalTo: defaultCollection.view.trailingAnchor, constant: 10),
            videoCollection.view.topAnchor.constraint(equalTo: profileView.photoScrollView.topAnchor),
            videoCollection.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            videoCollection.view.heightAnchor.constraint(equalTo: profileView.photoScrollView.heightAnchor),
            
            tagCollection.view.leadingAnchor.constraint(equalTo: videoCollection.view.trailingAnchor, constant: 10),
            tagCollection.view.topAnchor.constraint(equalTo: profileView.photoScrollView.topAnchor),
            tagCollection.view.widthAnchor.constraint(equalTo: view.widthAnchor),
            tagCollection.view.heightAnchor.constraint(equalTo: profileView.photoScrollView.heightAnchor),
        ])
    }
    
    func setupAction() {
        profileView.defaultCollectionButton.addTarget(self, action: #selector(moveScroll), for: .touchUpInside)
        profileView.videoCollectionButton.addTarget(self, action: #selector(moveScroll), for: .touchUpInside)
        profileView.tagCollectionButton.addTarget(self, action: #selector(moveScroll), for: .touchUpInside)
    }
    
    @objc func moveScroll(_ sender: UIButton) {
        switch sender {
        case profileView.defaultCollectionButton:
            let firstCoordinates: CGFloat = 0
            profileView.photoScrollView.setContentOffset(CGPoint(x: firstCoordinates, y: 0), animated: true)
            setupCollectionController(sender)
            setupHighlight(sender)
        case profileView.videoCollectionButton:
            let secondCoordinates = CGFloat(1) * profileView.photoScrollView.frame.size.width + 10
            profileView.photoScrollView.setContentOffset(CGPoint(x: secondCoordinates, y: 0), animated: true)
            setupCollectionController(sender)
            setupHighlight(sender)
        case profileView.tagCollectionButton:
            let thirdCoordinates = CGFloat(2) * profileView.photoScrollView.frame.size.width + 20
            profileView.photoScrollView.setContentOffset(CGPoint(x: thirdCoordinates, y: 0), animated: true)
            setupCollectionController(sender)
            setupHighlight(sender)
        default: return
        }
    }
    
    func setupHighlight(_ sender: UIButton) {
        NSLayoutConstraint.deactivate(profileView.highlightConstraints)
        profileView.highlightConstraints = [
            profileView.highlightView.leadingAnchor.constraint(equalTo: sender.leadingAnchor),
            profileView.highlightView.trailingAnchor.constraint(equalTo: sender.trailingAnchor),
            profileView.highlightView.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: -3),
            profileView.highlightView.heightAnchor.constraint(equalToConstant: 3)
        ]
        NSLayoutConstraint.activate(profileView.highlightConstraints)
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupCollectionController(_ sender: UIButton) {
        profileView.defaultCollectionButton.setImage(UIImage(named: "grid"), for: .normal)
        profileView.videoCollectionButton.setImage(UIImage(named: "video"), for: .normal)
        profileView.tagCollectionButton.setImage(UIImage(named: "tag"), for: .normal)
        
        switch sender {
        case profileView.defaultCollectionButton:
            sender.setImage(UIImage(named: "selectGrid"), for: .normal)
        case profileView.videoCollectionButton:
            sender.setImage(UIImage(named: "selectVideo"), for: .normal)
        case profileView.tagCollectionButton:
            sender.setImage(UIImage(named: "selectTag"), for: .normal)
        default: return
        }
    }
}
extension ProfileViewController: UIScrollViewDelegate {
    
    // 스크롤 뷰에서 사용자가 드래그를 놓았을 때 호출
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // targetContentOffset
        // 스크롤이 멈추는 위치를 나타내는 CGPoint 값을 가리키는 포인터입니다, 이 값을 변경하면 스크롤 뷰의 목표 스크롤 위치를 조절할 수 있습니다.
        
        let pageWidth = scrollView.frame.size.width
        // pageWidth는 스크롤 뷰 페이지의 너비를 나타냅니다. 페이지의 너비는 스크롤뷰의 프레임 크기와 동일
        let xOffset = targetContentOffset.pointee.x
        // xOffset은 스크롤 뷰에서 현재 스크롤 위치를 나타내는 값
        let spacing = CGFloat(10) // 페이지 간 간격
        // xOffset을 기반으로 현재 페이지를 결정합니다.
        let currentPage: Int
        
        // velocity 매개변수는 사용자 드래그의 속도를 나타내는 CGPoint 값 / velocity.x는 가로 방향 스크롤의 속도
        // 스크롤 방향을 확인합니다.
        if velocity.x > 0 {
            // 오른쪽으로 스크롤할 때 다음 페이지로 이동
            targetContentOffset.pointee.x = ceil((xOffset - spacing) / (pageWidth + spacing)) * (pageWidth + spacing)
            currentPage = Int(ceil((xOffset - spacing) / (pageWidth + spacing)))
            
        } else if velocity.x < 0 {
            // 왼쪽으로 스크롤할 때 이전 페이지로 이동
            targetContentOffset.pointee.x = floor((xOffset + spacing) / (pageWidth + spacing)) * (pageWidth + spacing)
            currentPage = Int(floor((xOffset + spacing) / (pageWidth + spacing)))
            
        } else {
            // 속도가 0인 경우, 현재 위치에서 가장 가까운 페이지로 이동
            targetContentOffset.pointee.x = round((xOffset) / (pageWidth + spacing)) * (pageWidth + spacing)
            currentPage = Int(round((xOffset) / (pageWidth + spacing)))
            
        }
        // currentPage에 따라 액션을 수행합니다.
        switch currentPage {
        case 0:
            setupHighlight(profileView.defaultCollectionButton)
            setupCollectionController(profileView.defaultCollectionButton)
        case 1:
            setupHighlight(profileView.videoCollectionButton)
            setupCollectionController(profileView.videoCollectionButton)
        case 2:
            setupHighlight(profileView.tagCollectionButton)
            setupCollectionController(profileView.tagCollectionButton)
        default:
            break
        }
    }
    
    /* 이 코드에서, spacing 변수는 페이지 간 간격을 나타내며, 스크롤 방향에 따라 다음 페이지나 이전 페이지로 이동할 때 targetContentOffset을 설정하는 데 사용됩니다. 페이지의 너비와 간격을 함께 고려하여 적절한 페이지 위치로 이동하도록 계산됩니다. 이렇게 수정하면 페이지 간 간격을 고려하면서 스크롤 뷰가 동작하게 됩니다. 페이지 이동이 간격을 포함하여 이루어집니다. */
}

