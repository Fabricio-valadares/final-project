import UIKit

class FavoritesController: UIViewController {
  
    //MARK: - Atributes
    
    private var repos = [Repository](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
       
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
        configureUI()
        fetchRepos()
    }

    
    //MARK: - Helpers

    private func configureUI(){
        tableView.addConstraintsToFillView(view)
    }
    
    private func configureTabBar(){
        title = "Favorites"
    }
        
    private func fetchRepos(){
        self.repos = ManagedObjectContext.shared.list { result in
            switch result {
                case .Success:
                    print("Sucesso")
                case .Error(let error):
                    print(error)
            }
        }

    }
    
    private func deleteFavorite(id: Int) {
        ManagedObjectContext.shared.delete(id: id) { result in
            switch result {
            case .Success:
                print("Sucesso")
            case .Error(let error):
                print(error)
            }
        }
    }
}

//MARK: - Tableview configuration

extension FavoritesController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let repo = repos[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.setup(name: repo.name, description: repo.login, imageUrl: repo.avatarURL)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetails = repos[indexPath.row]
        let repoDetailsController = RepoDetailsController(repoName: repoDetails.name, imagem: repoDetails.owner.avatarURL, authorName: repoDetails.owner.login, numberOfViewers: String(repoDetails.watchersCount), createdAt: repoDetails.createdAt, license: repoDetails.license?.name ?? "This repository has no License", repoLink: repoDetails.url, description: repoDetails.description ?? "This repository has no description")
        navigationController?.pushViewController(repoDetailsController  , animated: true)
        
    }
    
}

