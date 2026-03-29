import UIKit

final class SuperHumanCardView: UIView {
    
    private var humanId: Int?
    
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
    
    private let statsStackView: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 0
        s.alignment = .fill
        s.distribution = .fill
        return s
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
        addSubview(statsStackView)
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset),
            avatarImageView.widthAnchor.constraint(equalToConstant: 164),
            avatarImageView.heightAnchor.constraint(equalToConstant: 164),
            
            button.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            button.widthAnchor.constraint(equalToConstant: 26),
            button.heightAnchor.constraint(equalToConstant: 26),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 8),
            
            statsStackView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 13),
            statsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            statsStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -12),
            statsStackView.widthAnchor.constraint(equalToConstant: 71),
            
            bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: inset),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: HumanModel) {
        humanId = model.id
        nameLabel.text = model.name
        avatarImageView.image = UIImage(named: model.titleImage)
        backgroundColor = model.color
        
        let favorite = ModelData.shared.human(withId: model.id)?.isFavorite ?? model.isFavorite
        button.isSelected = favorite
        
        StackHelper.rebuildStatsStack(from: model.state, statsStackView: statsStackView, whereMake: "Card")
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        guard let id = humanId else { return }
        sender.isSelected.toggle()
        ModelData.shared.setFavorite(id: id, isFavorite: sender.isSelected)
    }
}
