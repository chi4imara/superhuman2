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
    
    private let statsLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        l.textColor = .white
        l.numberOfLines = 0
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(statsLabel)
        
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 94),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 179),
            nameLabel.heightAnchor.constraint(equalToConstant: 41),
            
            avatarImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 37),
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 164),
            avatarImageView.heightAnchor.constraint(equalToConstant: 164),
            
            statsLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
        
        let parts = human.state
            .sorted { $0.key < $1.key }
            .map { "\($0.value) \($0.key)" }
        statsLabel.text = parts.joined(separator: "\n")
    }
}
