import UIKit

class StopWatchView: UIView {
    
    lazy var watchView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.addSubview(watchLabel)
        
        return v
    }()
    
    let watchLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .boldSystemFont(ofSize: 40)
        l.backgroundColor = .clear
        l.clipsToBounds = true
        l.layer.cornerRadius = 125
        l.layer.borderWidth = 10
        l.layer.borderColor = UIColor.orange.cgColor
        l.backgroundColor = .black
        l.textAlignment = .center
        l.textColor = .white
        return l
    }()
    
    let okAtion: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("START", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 20)
        b.backgroundColor = .black
        b.clipsToBounds = true
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 5
        b.layer.borderColor = UIColor.orange.cgColor
        return b
    }()
    
    let pauseAtion: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("RESET", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .boldSystemFont(ofSize: 20)
        b.backgroundColor = .black
        b.clipsToBounds = true
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 5
        b.layer.borderColor = UIColor.orange.cgColor
        return b
    }()
    
    lazy var buttonSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [okAtion, pauseAtion])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 20
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.backgroundColor = .clear
        return sv
    }()
    
    lazy var stopSV: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [watchView, buttonSV])
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(stopSV)
        self.backgroundColor = .clear
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func autoLayout() {
        NSLayoutConstraint.activate([
            stopSV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            stopSV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            stopSV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            
            watchView.leadingAnchor.constraint(equalTo: stopSV.leadingAnchor),
            watchView.trailingAnchor.constraint(equalTo: stopSV.trailingAnchor),
            watchView.topAnchor.constraint(equalTo: stopSV.topAnchor),
            watchView.heightAnchor.constraint(equalToConstant: 300),

            watchLabel.centerXAnchor.constraint(equalTo: watchView.centerXAnchor),
            watchLabel.centerYAnchor.constraint(equalTo: watchView.centerYAnchor),
            watchLabel.widthAnchor.constraint(equalToConstant: 250),
            watchLabel.heightAnchor.constraint(equalToConstant: 250),

            buttonSV.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
