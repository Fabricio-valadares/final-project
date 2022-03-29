
import UIKit

struct DataDevelopers {
    var name: String
    var occupation: String
    var phone: String
    var email: String
    var linkedin: String
    var twitter: String
    var profile: String
}


class SquadViewController: UIViewController {
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        
        table.register(UserDeveloperTableViewCell.self, forCellReuseIdentifier: UserDeveloperTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        table.translatesAutoresizingMaskIntoConstraints = false
        
        return table
    }()

    
    var users: [DataDevelopers] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Time"
        
        users = [DataDevelopers(name: "Pamella Lima", occupation: "Ocupação", phone: "(00)00000-0000", email: "funalo@mail.com", linkedin: "https://dominio.com.br", twitter: "user123", profile: "https://avatars.githubusercontent.com/u/45980325?v=4"), DataDevelopers(name: "Miller César", occupation: "Ocupação", phone: "(00)00000-0000", email: "funalo@mail.com", linkedin: "https://dominio.com.br", twitter: "user123", profile: "https://avatars.githubusercontent.com/u/20051554?v=4"),DataDevelopers(name: "Fabricio Valadares", occupation: "Full-Stack Developer", phone: "(00)00000-0000", email: "funalo@mail.com", linkedin: "https://dominio.com.br", twitter: "user123", profile: "https://avatars.githubusercontent.com/u/63164587?v=4"), DataDevelopers(name: "Giovanna", occupation: "Ocupação", phone: "(00)00000-0000", email: "funalo@mail.com", linkedin: "https://dominio.com.br", twitter: "user123", profile: "https://avatars.githubusercontent.com/u/47362960?v=4"), DataDevelopers(name: "Melquias Ribeiro", occupation: "Ocupação", phone: "(00)00000-0000", email: "funalo@mail.com", linkedin: "https://dominio.com.br", twitter: "user123", profile: "https://avatars.githubusercontent.com/u/54459438?v=4"), DataDevelopers(name: "Felipe Brigagão", occupation: "Ocupação", phone: "(00)00000-0000", email: "funalo@mail.com", linkedin: "https://dominio.com.br", twitter: "user123", profile: "https://avatars.githubusercontent.com/u/30760595?v=4")]
        
        tableView.rowHeight = 85
        
        view.addSubview(tableView)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


extension SquadViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showDeveloperContactViewController = ShowDeveloperContactViewController()
        
        if let _ = navigationController {
            navigationController?.pushViewController(showDeveloperContactViewController, animated: true)
        } else {
            present(showDeveloperContactViewController, animated: true)
        }
    }
}

extension SquadViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDeveloperTableViewCell.identifier, for: indexPath) as? UserDeveloperTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        
        cell.setup(with: user)
        
        return cell
    }
    
    
}
