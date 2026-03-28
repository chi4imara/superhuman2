import UIKit

class SuperHumanViewController: UIViewController  {
    
    private let label: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private let button: UIButton = {
        let starButton = UIButton(type: .custom)
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        starButton.tintColor = .yellow
        starButton.translatesAutoresizingMaskIntoConstraints = false
        
        return starButton
    }()
    
    private func layoutConstraint(container: UIView) {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 47),
            
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            button.topAnchor.constraint(equalTo: container.topAnchor, constant: 47),
            button.widthAnchor.constraint(equalToConstant: 26),
            button.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    func setupNavigationBar(title: String) {
        navigationItem.title = nil
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = title
        containerView.addSubview(label)
        
        button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        containerView.addSubview(button)
        
        layoutConstraint(container: containerView)
        
        navigationItem.titleView = containerView
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: view.frame.width),
            containerView.heightAnchor.constraint(equalToConstant: 80)
        ])
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
