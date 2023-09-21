import UIKit

class ProfileView: UIView {
    
// MARK: - UI
    // MARK: - mainImage, numberOfInfo
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.backgroundColor = .yellow
        image.image = UIImage(named: "12")
        return image
    }()
    
    let postLabel: ReusableInfoLabel = {
        let view = ReusableInfoLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberLabel.text = "120"
        view.kindLabel.text = "post"
        return view
    }()
    
    let followLabel: ReusableInfoLabel = {
        let view = ReusableInfoLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberLabel.text = "300"
        view.kindLabel.text = "follow"
        return view
    }()
    
    let followingLabel: ReusableInfoLabel = {
        let view = ReusableInfoLabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberLabel.text = "200"
        view.kindLabel.text = "following"
        return view
    }()
    
    lazy var infoLabelSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [postLabel, followLabel, followingLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.spacing = 5
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        return sv
    }()
    
    // MARK: - textLabel (name, info, link)
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "짱아"
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.text = "랙돌"
        return label
    }()
    
    let linkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemBlue
        label.text = "www.naver.com"
        return label
    }()
    
    lazy var textSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nameLabel, infoLabel, linkLabel])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 2
        return sv
    }()
    
    // MARK: - button (message, follow, more)
    let followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 15)]
        let attributedTitle = NSAttributedString(string: "Follow", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let messageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setTitleColor(.black, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 15)]
        let attributedTitle = NSAttributedString(string: "Message", attributes: attributes)
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderWidth = 2
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setImage(UIImage(named: "More"), for: .normal)
        
        return button
    }()
    
    lazy var buttonSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [followButton, messageButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 5
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    // MARK: - border
    let borderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: - button(collectionView Control)
    let defaultCollectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "selectGrid"), for: .normal)
        return button
    }()
    
    let videoCollectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "video"), for: .normal)
        return button
    }()
    
    let tagCollectionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "tag"), for: .normal)
        return button
    }()
    
    lazy var collectionControlButtonSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [defaultCollectionButton, videoCollectionButton, tagCollectionButton])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    // MARK: - highlightView
    let highlightView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var highlightConstraints: [NSLayoutConstraint] =
    [highlightView.leadingAnchor.constraint(equalTo: defaultCollectionButton.leadingAnchor),
     highlightView.trailingAnchor.constraint(equalTo: defaultCollectionButton.trailingAnchor),
     highlightView.topAnchor.constraint(equalTo: defaultCollectionButton.bottomAnchor, constant: -3),
     highlightView.heightAnchor.constraint(equalToConstant: 3)]
    
    // MARK: - collectionView
    let photoScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.decelerationRate = .fast
        view.backgroundColor = .clear
        view.bounces = false
        return view
    }()
    
// MARK: - 생성자
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - SETUP
    func setConstraints() {
        addSubview(profileImage)
        addSubview(infoLabelSV)
        addSubview(textSV)
        addSubview(buttonSV)
        addSubview(moreButton)
        addSubview(borderView)
        addSubview(collectionControlButtonSV)
        addSubview(highlightView)
        addSubview(photoScrollView)
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            profileImage.topAnchor.constraint(equalTo: topAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            
            infoLabelSV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            infoLabelSV.topAnchor.constraint(equalTo: topAnchor),
            infoLabelSV.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 14),
            infoLabelSV.heightAnchor.constraint(equalToConstant: 100),
            
            textSV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            textSV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            textSV.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            textSV.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            buttonSV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            buttonSV.topAnchor.constraint(equalTo: textSV.bottomAnchor, constant: 20),
            buttonSV.heightAnchor.constraint(equalToConstant: 30),
            
            moreButton.leadingAnchor.constraint(equalTo: buttonSV.trailingAnchor, constant: 5),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            moreButton.topAnchor.constraint(equalTo: textSV.bottomAnchor, constant: 20),
            moreButton.widthAnchor.constraint(equalToConstant: 30),
            moreButton.heightAnchor.constraint(equalToConstant: 30),
            
            borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            borderView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 10),
            borderView.heightAnchor.constraint(equalToConstant: 1),
            
            collectionControlButtonSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionControlButtonSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionControlButtonSV.topAnchor.constraint(equalTo: borderView.bottomAnchor, constant: 5),
            collectionControlButtonSV.heightAnchor.constraint(equalToConstant: 35),
            
            photoScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            photoScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            photoScrollView.topAnchor.constraint(equalTo: collectionControlButtonSV.bottomAnchor),
            photoScrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate(highlightConstraints)
        photoScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3 + 20, height: 0)
    }
}

