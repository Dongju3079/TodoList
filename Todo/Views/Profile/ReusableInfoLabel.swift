
import UIKit

class ReusableInfoLabel: UIView {
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let kindLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [numberLabel, kindLabel])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(labelSV)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            labelSV.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelSV.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelSV.topAnchor.constraint(equalTo: topAnchor),
            labelSV.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
