import UIKit

final class SuperHumanCardView: UIView {
    
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 0
        iv.backgroundColor = .clear
        return iv
    }()
    
    private let button: UIButton = {
        let starButton = UIButton(type: .custom)
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        starButton.tintColor = .yellow
        starButton.translatesAutoresizingMaskIntoConstraints = false
        
        return starButton
    }()
    
    private let nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        l.textColor = .white
        l.numberOfLines = 2
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 24
        layer.masksToBounds = true
        button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        
        addSubview(avatarImageView)
        addSubview(button)
        addSubview(nameLabel)
        addSubview(statsLabel)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            avatarImageView.widthAnchor.constraint(equalToConstant: 164),
            avatarImageView.heightAnchor.constraint(equalToConstant: 164),
            
            button.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            button.widthAnchor.constraint(equalToConstant: 26),
            button.heightAnchor.constraint(equalToConstant: 26),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            nameLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 8),
            
            statsLabel.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 13),
            statsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            statsLabel.trailingAnchor.constraint(lessThanOrEqualTo: avatarImageView.leadingAnchor, constant: -inset),
            statsLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -inset),
            
            bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: inset),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: HumanModel) {
        nameLabel.text = model.name
        avatarImageView.image = UIImage(named: model.titleImage)
        backgroundColor = model.color
        
        let parts = model.state
            .sorted { $0.key < $1.key }
            .map { "\($0.value) \($0.key.prefix(3))" }
        statsLabel.text = parts.joined(separator: "\n")
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {

        sender.isSelected.toggle()

        if sender.isSelected {
            print("Звездочка добавлена в избранное")
        } else {
            print("Звездочка удалена из избранного")
        }
    }
}
