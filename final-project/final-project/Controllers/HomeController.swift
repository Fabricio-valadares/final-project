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
    private var filteredRepos:[Item] = []
       
    private var isAsc:Bool = false
    
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
    
    lazy var searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.automaticallyShowsScopeBar = false
        searchBar.searchBar.searchTextField.placeholder = "Search..."
        searchBar.searchBar.sizeToFit()
        searchBar.searchResultsUpdater = self
        
        return searchBar

    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = searchBar.searchBar
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
        navigationItem.rightBarButtonItem = orderButton
    }
    
    @objc func handleOrdenates(){
        if(isAsc){
            repos.sort {$0.name.lowercased() < $1.name.lowercased()}
            isAsc = false
        }else {
            repos.sort {$0.name.lowercased() > $1.name.lowercased()}
            isAsc = true
        }
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
        if searchBar.isActive && searchBar.searchBar.text != ""{
            return filteredRepos.count
        }
        
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let repo:Item
        
        if searchBar.isActive && searchBar.searchBar.text != ""{
            repo = filteredRepos[indexPath.row]
        }else{
            repo = repos[indexPath.row]
        }

     
        
        cell.accessoryType = .disclosureIndicator
        cell.setup(name: repo.name, description: repo.owner.login, imageUrl: repo.owner.avatarURL)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let repoDetails = repos[indexPath.row]
        
        let repoDetails:Item
        
        if searchBar.isActive && searchBar.searchBar.text != ""{
            repoDetails = filteredRepos[indexPath.row]
        }else{
            repoDetails = repos[indexPath.row]
        }
        
        let repoDetailsController = RepoDetailsController(item: Repository(id: repoDetails.id, name: repoDetails.name, description: repoDetails.description ?? "", avatarURL: repoDetails.owner.avatarURL, createdAt: repoDetails.createdAt, watchersCount: repoDetails.watchersCount, login: repoDetails.owner.login, url: repoDetails.htmlURL, license: repoDetails.license?.name ?? "", authorName: repoDetails.owner.login))
        
        //self.searchBar.isActive = false
        //self.searchBar.searchBar.isHidden = true
        navigationController?.pushViewController(repoDetailsController, animated: true)
        
    }
    
}

//MARK: - Search configuration

extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        if !searchController.isActive{
            return
        }
        
        guard let searchedText = searchController.searchBar.text else {
            return
        }

       let filteredRepos = repos.filter{ repo in
           return repo.name.lowercased().contains(searchedText.lowercased())
        }
        
        self.filteredRepos = filteredRepos
        self.tableView.reloadData()
        
    }
}
