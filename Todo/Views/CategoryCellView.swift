import UIKit

class CategoryCellView: UICollectionViewCell {
    
    var categoryText: String? {
        didSet {
            categoryLabel.text = categoryText
        }
    }
    
    let categoryLabel: UILabel = {
        let category = UILabel()
        category.translatesAutoresizingMaskIntoConstraints = false
        category.backgroundColor = .clear
        category.textColor = .black
        category.textAlignment = .center
        category.font = .boldSystemFont(ofSize: 15)
        category.numberOfLines = 2
        return category
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 내장되어 있는 contentView에 라운드 처리를 한다.
        self.contentView.addSubview(categoryLabel)
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.black.cgColor
        
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
        
    }
}
