import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    var categoryText: String? {
        didSet {
            guard let categoryText = categoryText else { return }
            myPhoto.image = UIImage(named: categoryText)
        }
    }
    
    let myPhoto: UIImageView = {
        let myPhoto = UIImageView()
        myPhoto.translatesAutoresizingMaskIntoConstraints = false
        myPhoto.backgroundColor = .clear
        return myPhoto
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(myPhoto)

        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        self.contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            myPhoto.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            myPhoto.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            myPhoto.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            myPhoto.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.myPhoto.image = nil
    }
}
