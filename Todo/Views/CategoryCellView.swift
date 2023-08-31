import UIKit

class CategoryCellView: UICollectionViewCell {
    
    /*
     🐝 셀이 선택됐는지 구분할 수 있는 변수, 간단히 셀의 레이어만 변경할 때는 추가적인 구현이 필요없지만
        셀의 다중 선택, 선택한 셀 취소 등의 기능을 구현하려면 didSelected에서 이전 셀과, 지금 셀 등 추가적인 변수를 저장해서 구분해줘야 한다.
     */
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.layer.borderColor = UIColor.red.cgColor
            } else {
                contentView.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
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
//        contentView.layer.borderColor = UIColor.black.cgColor
        
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
