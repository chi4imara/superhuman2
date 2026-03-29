import UIKit

class SuperHumanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var models: [HumanModel] = []
    private var categoryFilter: String = ""
    
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
    
    private let headerContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private static let headerHeight: CGFloat = 96 + 47
    
    func setupNavigationBar(title: String) {
        label.text = title
        
        guard headerContainerView.superview == nil else { return }
        
        headerContainerView.addSubview(label)
        headerContainerView.addSubview(button)
        button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor, constant: -8),
            
            button.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -12),
            button.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: 56),
            button.widthAnchor.constraint(equalToConstant: 26),
            button.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        view.addSubview(headerContainerView)
        
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerContainerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerContainerView.heightAnchor.constraint(equalToConstant: Self.headerHeight)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleFavoriteDidChange),
            name: .humanFavoriteDidChange,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadFilteredModels()
        tableView.reloadData()
    }
    
    private func reloadFilteredModels() {
        guard !categoryFilter.isEmpty else { return }
        var list = ModelData.shared.human.filter { $0.category == categoryFilter }
        if button.isSelected {
            list = list.filter(\.isFavorite)
        }
        models = list
    }
    
    func setupHumanTable(filterCategory: String) {
        categoryFilter = filterCategory
        reloadFilteredModels()
        
        if tableView.superview == nil {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(HumanCardTableViewCell.self, forCellReuseIdentifier: HumanCardTableViewCell.reuseId)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 196
            
            view.addSubview(tableView)
            
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Self.headerHeight),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
        tableView.reloadData()
    }
    
    @objc private func handleFavoriteDidChange() {
        reloadFilteredModels()
        if tableView.superview != nil {
            tableView.reloadData()
        }
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
        reloadFilteredModels()
        tableView.reloadData()
    }
}
