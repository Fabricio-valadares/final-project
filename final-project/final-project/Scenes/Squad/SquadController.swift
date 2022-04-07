
import UIKit


class SquadController: UIViewController {
    
    private let viewModel: SquadViewModel = SquadViewModel()
    
    //MARK: - Atributes
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.rowHeight = 101

        return tableView
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Time"
        
        view.addSubview(tableView)
        setupConstraints()
        
        viewModel.delegate = self
        
        viewModel.fetchDevelopers()
    }
    
    //MARK: - Helpers
    
    private func setupConstraints() {
        tableView.addConstraintsToFillView(view)
    }
}

//MARK: - Tableview configuration

extension SquadController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.developers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let user = viewModel.developers[indexPath.row]
            
        cell.setup(name: user.name, description: user.occupation, imageUrl: user.profile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let developerDetails = viewModel.developers[indexPath.row]
        
        let showDeveloperContactViewController = DevelopersDetailsController(developer: developerDetails)
        
        if let _ = navigationController {
            navigationController?.pushViewController(showDeveloperContactViewController, animated: true)
        } else {
            present(showDeveloperContactViewController, animated: true)
        }
    }
}

// MARK: - Delegate configuration
extension SquadController: SquadDelegate {
    func updateTableView() {
        tableView.reloadData()
    }
}
