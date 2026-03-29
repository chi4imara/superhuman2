import UIKit

final class SuperHumanDetailViewController: UIViewController {
    
    private static let actionAccent = UIColor(red: 0.947, green: 0.641, blue: 0.235, alpha: 1)
    
    private var humanId: Int?
    
    private let gradientLayer = CAGradientLayer()
    
    private let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.alwaysBounceVertical = true
        s.showsVerticalScrollIndicator = true
        s.keyboardDismissMode = .onDrag
        return s
    }()
    
    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
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
        l.numberOfLines = 0
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
    
    private let actionButton: UIButton = {
        let b = UIButton(type: .system)
        b.translatesAutoresizingMaskIntoConstraints = false
        
        var config = UIButton.Configuration.plain()
        config.title = "Add to favorites"
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var out = incoming
            out.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            return out
        }
        config.background.cornerRadius = 16
        config.contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 24, bottom: 14, trailing: 24)
        
        b.configuration = config
        
        b.configurationUpdateHandler = { button in
            guard var cfg = button.configuration else { return }
            let accent = SuperHumanDetailViewController.actionAccent
            
            switch (button.isSelected, button.isHighlighted) {
            case (_, true):
                cfg.background.backgroundColor = accent
                cfg.background.strokeWidth = 0
                cfg.background.strokeColor = .clear
                cfg.baseForegroundColor = .black
            case (true, false):
                cfg.background.backgroundColor = accent
                cfg.background.strokeWidth = 0
                cfg.background.strokeColor = .clear
                cfg.baseForegroundColor = .black
            case (false, false):
                cfg.background.backgroundColor = .clear
                cfg.background.strokeColor = accent
                cfg.background.strokeWidth = 2
                cfg.baseForegroundColor = accent
            }
            
            button.configuration = cfg
        }
        
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(statsStackView)
        contentView.addSubview(actionButton)
        
        let contentGuide = scrollView.contentLayoutGuide
        let frameGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            avatarImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 37),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 164),
            avatarImageView.heightAnchor.constraint(equalToConstant: 164),
            
            statsStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
            statsStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            statsStackView.widthAnchor.constraint(equalToConstant: 158),
            
            actionButton.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 150),
            actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    func configure(with human: HumanModel) {
        humanId = human.id
        
        gradientLayer.colors = [
            human.color.cgColor,
            UIColor.black.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        nameLabel.text = human.name
        
        avatarImageView.image = UIImage(named: human.titleImage)
        
        StackHelper.rebuildStatsStack(from: human.state, statsStackView: statsStackView, whereMake: .detail)
        
        let current = ModelData.shared.human(withId: human.id) ?? human
        actionButton.isSelected = current.isFavorite
        if var cfg = actionButton.configuration {
            cfg.title = current.isFavorite ? "In favorites" : "Add to favorites"
            actionButton.configuration = cfg
        }
        actionButton.setNeedsUpdateConfiguration()
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        guard let id = humanId else { return }
        sender.isSelected.toggle()
        ModelData.shared.setFavorite(id: id, isFavorite: sender.isSelected)
        
        guard var cfg = sender.configuration else { return }
        cfg.title = sender.isSelected ? "In favorites" : "Add to favorites"
        sender.configuration = cfg
        sender.setNeedsUpdateConfiguration()
    }
}
