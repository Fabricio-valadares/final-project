//
//  ViewController.swift
//  final-project
//
//  Created by FL00027 on 24/03/22.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

        private var repos = [Item](){
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
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.idetifier)

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.view.addSubview(self.tableView)
        self.configConstraints()
        self.fetchRepos()
    }

    private func configConstraints(){
        NSLayoutConstraint.activate([
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])
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


extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.idetifier, for: indexPath) as? CustomTableViewCell else {return UITableViewCell()}
        
        let repo = repos[indexPath.row]
        
        cell.setup(with: repo)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}


