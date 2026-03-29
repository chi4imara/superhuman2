import UIKit

class SuperHumanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var models: [HumanModel] = []
    
    private let tableView: UITableView = {
        let t = UITableView(frame: .zero, style: .plain)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.separatorStyle = .none
        t.showsVerticalScrollIndicator = true
        
        return t
    }()

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

    func setupNavigationBar(title: String) {
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 96 + 47))
        containerView.backgroundColor = .black
        containerView.translatesAutoresizingMaskIntoConstraints = false

        label.text = title
        containerView.addSubview(label)

        button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        containerView.addSubview(button)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

            button.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            button.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 56),
            button.widthAnchor.constraint(equalToConstant: 26),
            button.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        view.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 96 + 47)
        ])
    }

    func setupHumanTable(filterCategory: String) {
        models = ModelData.shared.human.filter { $0.category == filterCategory }

        if tableView.superview == nil {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(HumanCardTableViewCell.self, forCellReuseIdentifier: HumanCardTableViewCell.reuseId)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 196

            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 143),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HumanCardTableViewCell.reuseId,
            for: indexPath
        ) as? HumanCardTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = models[indexPath.row]
        let detailVC = SuperHumanDetailViewController()
        detailVC.configure(with: model)
        navigationController?.pushViewController(detailVC, animated: true)
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
