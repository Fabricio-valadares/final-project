import UIKit

class FavoritesController: UIViewController {
    
    private let viewModel: FavoritesViewModel = FavoritesViewModel()
  
    //MARK: - Atributes
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        viewModel.delegate = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
        configureUI()
        viewModel.fetchRepositories()
    }

    
    //MARK: - Helpers

    private func configureUI(){
        tableView.addConstraintsToFillView(view)
    }
    
    private func configureTabBar(){
        title = "Favorites"
    }
}

//MARK: - Tableview configuration
extension FavoritesController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRepositoriesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let repo = viewModel.repositories[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.setup(name: repo.name, description: repo.login, imageUrl: repo.avatarURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    private func showAlertError(_ message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Erro", style: .default, handler: { action in
                    //Fazer algo se necessario
                }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetails = viewModel.repositories[indexPath.row]
        let repoDetailsController = RepoDetailsController(item: repoDetails)
        navigationController?.pushViewController(repoDetailsController  , animated: true)
    }
}

extension FavoritesController: FavoritesDelegate {
    func fetchFavoritesSuccess() {
        tableView.reloadData()
    }
    
    func fetchFavoritesErro(_ error: String) {
        showAlertError(error)
    }
}

