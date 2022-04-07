import UIKit
import SwiftUI

class HomeController: UIViewController {
    
    public var viewModel: HomeViewModel = HomeViewModel()
    
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
        
        viewModel.delegate = self
        
        configureUI()
        viewModel.fetchRepositories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTabBar()
    }
    
    //MARK: - Binders
    @objc func handleOrdenates(){
        viewModel.orderRepositories()
    }

    //MARK: - Helpers

    private func configureUI(){
        tableView.addConstraintsToFillView(view)
    }
    
    private func configureTabBar(){
        title = "List"
        navigationItem.rightBarButtonItem = orderButton
    }
    
    private func showAlertError(_ message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Erro", style: .default, handler: { action in
                    //Fazer algo se necessario
                }))
        
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Tableview configuration

extension HomeController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isActive && searchBar.searchBar.text != ""{
            return viewModel.filteredRepos.count
        }
        
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let repo:Item?
        
        if searchBar.isActive && searchBar.searchBar.text != ""{
            repo = viewModel.filteredRepos[indexPath.row]
        }else{
            repo = viewModel.repositories[indexPath.row]
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.setup(name: repo?.name ?? "", description: repo?.owner.login ?? "", imageUrl: repo?.owner.avatarURL ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let repoDetails = repos[indexPath.row]
        
        let repoDetails:Item
        
        if searchBar.isActive && searchBar.searchBar.text != ""{
            repoDetails = viewModel.filteredRepos[indexPath.row]
        }else{
            repoDetails = viewModel.repositories[indexPath.row]
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
        
        viewModel.filterRepositories(searchedText)
        
    }
}

extension HomeController: HomeDelegate {
    func fetchRepositoriesError(_ error: String) {
        showAlertError(error)
    }
    
    func updateTableView() {
        print("atualizando table view")
        tableView.reloadData()
    }
}
