import UIKit

final class SuperHumanDetailViewController: UIViewController {
    
    private let gradientLayer = CAGradientLayer()
    
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 0
        iv.backgroundColor = .clear
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        l.textColor = .white
        l.numberOfLines = 1
        l.textAlignment = .center
        return l
    }()
    
    private let statsStackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 16
        s.alignment = .fill
        s.distribution = .fill
        return s
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(statsStackView)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 94),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 179),
            nameLabel.heightAnchor.constraint(equalToConstant: 41),
            
            avatarImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 37),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 164),
            avatarImageView.heightAnchor.constraint(equalToConstant: 164),
            
            statsStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsStackView.widthAnchor.constraint(equalToConstant: 158),
            statsStackView.heightAnchor.constraint(equalToConstant: 212),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func configure(with human: HumanModel) {
        gradientLayer.colors = [
            human.color.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        nameLabel.text = human.name
        avatarImageView.image = UIImage(named: human.titleImage)
        
        rebuildStatsStack(from: human.state)
    }
    
    private func rebuildStatsStack(from state: [String: Int]) {
        statsStackView.arrangedSubviews.forEach { v in
            statsStackView.removeArrangedSubview(v)
            v.removeFromSuperview()
        }
        
        for (key, value) in state.sorted(by: { $0.key < $1.key }) {
            statsStackView.addArrangedSubview(makeStatRow(name: key, value: value))
        }
    }
    
    private func makeStatRow(name: String, value: Int) -> UIStackView {
        let keyLabel = UILabel()
        keyLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        keyLabel.textColor = UIColor.white.withAlphaComponent(0.38)
        keyLabel.text = name
        keyLabel.numberOfLines = 2
        keyLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        valueLabel.textColor = .white
        valueLabel.text = "\(value)"
        valueLabel.textAlignment = .right
        valueLabel.setContentHuggingPriority(.required, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let row = UIStackView(arrangedSubviews: [valueLabel, keyLabel])
        row.axis = .horizontal
        row.alignment = .firstBaseline
        row.spacing = 16
        row.distribution = .fill
        
        return row
    }
}
