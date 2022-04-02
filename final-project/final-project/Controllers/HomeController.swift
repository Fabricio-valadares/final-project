import UIKit
import SwiftUI

class HomeController: UIViewController {
    
    //MARK: - Atributes
    
    private var repos = [Item](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var orderButton:UIBarButtonItem = {
        orderButton = UIBarButtonItem()
        orderButton.image = UIImage(systemName: "slider.horizontal.3")
        orderButton.style = .plain
        orderButton.target = self
        orderButton.action = nil
        orderButton.tintColor = .black
        orderButton.action = #selector(handleOrdenates)
        return orderButton
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search..."
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.autocapitalizationType = .none
        
        return searchBar

    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = searchBar
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
        configureUI()
        fetchRepos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }

    
    //MARK: - Helpers

    private func configureUI(){
        tableView.addConstraintsToFillView(view)
    }
    
    private func configureTabBar(){
        title = "List"
        //let aparence = UITabBarAppearance()
        navigationItem.rightBarButtonItem = orderButton
        
    }
    
    @objc func handleOrdenates(){
        print("ordening")
    }
    
    private func fetchRepos(){
        let service = FetchGitHubServices()
            service.fetchAll{
                result in
                switch result{
                    case .success(let repos):
                        self.repos = repos
                    case .failure(let error):
                        print(error.localizedDescription)
                }
        }
    }
}

//MARK: - Tableview configuration

extension HomeController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let repo = repos[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.setup(name: repo.name, description: repo.owner.login, imageUrl: repo.owner.avatarURL)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repoDetails = repos[indexPath.row]
        
        let repoDetailsController = RepoDetailsController(item: FavoriteRepo(id: repoDetails.id, name: repoDetails.name, description: repoDetails.description ?? "", avatarURL: repoDetails.owner.avatarURL, createdAt: repoDetails.createdAt, watchersCount: repoDetails.watchersCount, login: repoDetails.owner.login, url: repoDetails.url, license: repoDetails.license?.name ?? "", authorName: repoDetails.owner.login))
        
        navigationController?.pushViewController(repoDetailsController, animated: true)
        
    }
    
}


extension HomeController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let serched = searchBar.text {
            print(serched)
        } else {
            print("Sem url")
        }
    }
}
