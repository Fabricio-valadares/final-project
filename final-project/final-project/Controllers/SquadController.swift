
import UIKit


class SquadController: UIViewController {
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
    var users: [Developers] = []
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Time"
        users = [
            Developers(
                name: "Pamella Lima",
                occupation: "Ocupação",
                phone: "(83)99985-3998",
                email: "pamellavsl@gmail.com",
                linkedin: "https://www.linkedin.com/in/pamella-lima-91a4ab1b4/",
                twitter: "https://twitter.com/pamellusca",
                profile: "https://avatars.githubusercontent.com/u/45980325?v=4",
                description: "texto de exemplo"
            ),
            Developers(
                name: "Miller césar de Olivera",
                occupation: "Frontend Developer",
                phone: "(11)983177098",
                email: "miller00315@gmail.com",
                linkedin: "https://www.linkedin.com/in/millercesaroliveira/",
                twitter: "",
                profile: "https://avatars.githubusercontent.com/u/20051554?v=4",
                description: "Formado em sistemas de informacao, mineiro de Lavras sul de Minas Gerais, sou apaixonado por tecnologia e amo a área de desenvolvimento."
            ),
            Developers(
                name: "Fabricio Valadares",
                occupation: "Full-Stack Developer",
                phone: "(62)98475-8804",
                email: "fabriciovaladares0@gmail.com",
                linkedin: "https://www.linkedin.com/in/fabricio-valadares",
                twitter: "",
                profile: "https://avatars.githubusercontent.com/u/63164587?v=4",
                description: "Olá, meu nome é Fabricio e sou super curioso em aprender coisas novas e gosto muito de criar aplicações para usar no meu dia a dia."
            ),
            Developers(
                name: "Giovanna Moeller",
                occupation: "Desenvolvedora Web e iOS - Criadora \nde Conteúdo",
                phone: "(14)991293534",
                email: "giovannagmoeller@gmail.com",
                linkedin: "https://linkedin.com/in/giovannamoeller",
                twitter: "", profile: "https://avatars.githubusercontent.com/u/47362960?v=4",
                description: "texto de exemplo"
            ),
            Developers(
                name: "Melquias Rosa Ribeiro",
                occupation: "fullstack developer",
                phone: "(98)981877537",
                email: "funalo@mail.com",
                linkedin: "https://www.linkedin.com/in/melquias-ribeiro-a10639182/",
                twitter: "@MelquiasRibeiro",
                profile: "https://avatars.githubusercontent.com/u/54459438?v=4",
                description: "texto de exemplo"
            ),
            Developers(
                name: "Felipe Brigagão",
                occupation: "Ocupação",
                phone: "(61)99460-5930",
                email: "felipe.brigagao@icloud.com",
                linkedin: "https://www.linkedin.com/in/felipebrigagaoalmeida/",
                twitter: "https://twitter.com/FelipeB_A",
                profile: "https://avatars.githubusercontent.com/u/30760595?v=4",
                description: "texto de exemplo"
            )
        ]
        
        view.addSubview(tableView)
        setupConstraints()
    }
    
    //MARK: - Helpers
    
    private func setupConstraints() {
        tableView.addConstraintsToFillView(view)
    }
}

    //MARK: - Tableview configuration

extension SquadController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
            
        cell.setup(name: user.name, description: user.occupation, imageUrl: user.profile)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let developerDetails = users[indexPath.row]
        let showDeveloperContactViewController = DevelopersDetilsController(developerPhoto: developerDetails.profile, developerName: developerDetails.name, developerPhone: developerDetails.phone, developerEmail: developerDetails.email, developerLinkedin: developerDetails.linkedin, developerTwitter: developerDetails.twitter, developerDescription: developerDetails.description)
        
        if let _ = navigationController {
            navigationController?.pushViewController(showDeveloperContactViewController, animated: true)
        } else {
            present(showDeveloperContactViewController, animated: true)
        }
    }
}
