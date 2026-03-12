import UIKit

class SuperheroesViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = nil
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Superheroes"
        titleLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        let starButton = UIButton(type: .custom)
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
        starButton.tintColor = .yellow
        starButton.translatesAutoresizingMaskIntoConstraints = false
        
        starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        
        containerView.addSubview(starButton)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 47),
            
            starButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            starButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 47),
            starButton.widthAnchor.constraint(equalToConstant: 26),
            starButton.heightAnchor.constraint(equalToConstant: 26)
        ])
        
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
