//
//  ViewController.swift
//  telaRepo
//
//  Created by Pamella Lima on 26/03/22.
//

import UIKit

class RepoViewController: UIViewController {
    
    let nomeRepo = "nome da Repo"
    var safeArea: UILayoutGuide!
    static let identifier = "RepoViewCell"
    
    func setup(imagem: String, nomeAutor: String, contObservadores: String, dataCriacao: String, licenca: String, link: String) {
       // title = nomeRepo
        imageRepoView.image = UIImage(named: imagem)
        nomeAutorLabel.text = nomeAutor
        quantContLabel.text = contObservadores
        data.text = dataCriacao
        licencaLabel.text = licenca
        linkTextView.text = link
        
    }
        
    
    lazy var imageRepoView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "stop")
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.textColor = .black
        subTitle.numberOfLines = 0
        subTitle.font = UIFont.systemFont(ofSize: 17)
        subTitle.text = "A curated list of awesome iOS ecosystem, including Objective-c and Swift Projects"
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return subTitle
    }()
    
    lazy var contentAuthorStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.contentMode = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
        
    }()
    
    // MARK: Autor
    
    lazy var iconAutorImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.crop.square")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        
        return image
    }()
    
    lazy var autorLabel: UILabel = {
        let autor = UILabel()
       // let stringAutor = UILabel()
       // let nomeAutor = UILabel()
        
        autor.font = UIFont.boldSystemFont(ofSize: 16)
        //autor.text = "  Autor: \(nomeAutorLabel.text!)"
        autor.text = "  Autor:"
         
        
//        stringAutor.font = UIFont.systemFont(ofSize: 12)
//        stringAutor.text = "Nome do autor"
//
//        autor.text = nomeAutor.text! + stringAutor.text!
        autor.translatesAutoresizingMaskIntoConstraints = false
        
        return autor
        
        
    }()
    
    lazy var nomeAutorLabel: UILabel = {
        let nomeAutor = UILabel()
        nomeAutor.font = UIFont.systemFont(ofSize: 16)
        nomeAutor.text = "Nome do Autor"
        nomeAutor.numberOfLines = 0
        
        nomeAutor.translatesAutoresizingMaskIntoConstraints = false
        
        return nomeAutor
    }()
    
    
    // MARK: Quantidade de visualização
    
    lazy var contentContStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.contentMode = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
        
    }()
    
    lazy var iconContObs: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "eye")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        
        return image
    }()
    
    lazy var contObsLabel: UILabel = {
        let contObs = UILabel()
       // let stringCont = UILabel()
        //let quantCont = UILabel()
        contObs.font = UIFont.boldSystemFont(ofSize: 16)
        contObs.text = "Contagem de observadores:"
        contObs.translatesAutoresizingMaskIntoConstraints = false
    
        return contObs
        
        
    }()
    
    lazy var quantContLabel: UILabel = {
        let quantCont = UILabel()
        quantCont.font = UIFont.systemFont(ofSize: 16)
        quantCont.text = "00000"
        quantCont.translatesAutoresizingMaskIntoConstraints = false
        return quantCont
        
        
    }()
    
    // MARK: Data
    
    lazy var contentDataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.contentMode = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
        
    }()
    
    lazy var iconData: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "alarm.fill")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        
        return image
    }()
    
    lazy var dataLabel: UILabel = {
        let dataCriacao = UILabel()
        dataCriacao.font = UIFont.boldSystemFont(ofSize: 16)
        dataCriacao.text = "  Data de criação:"
        dataCriacao.translatesAutoresizingMaskIntoConstraints = false
    
        return dataCriacao
        
        
    }()
    
    lazy var data: UILabel = {
        let data = UILabel()
        
        data.font = UIFont.systemFont(ofSize: 16)
        data.text = "00/00/0000"
        
        data.translatesAutoresizingMaskIntoConstraints = false
        
        return data
        
        
    }()
    
    // MARK: Licença
    
    lazy var contentLicenStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.contentMode = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
        
    }()
    
    lazy var iconLicen: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "globe")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .black
        
        return image
    }()
    
    lazy var licenLabel: UILabel = {
        let licencaProject = UILabel()
        licencaProject.font = UIFont.boldSystemFont(ofSize: 16)
        licencaProject.text = "  Licença:"
        licencaProject.translatesAutoresizingMaskIntoConstraints = false
    
        return licencaProject
        
    }()
    
    lazy var licencaLabel: UILabel = {
        let licen = UILabel()
        
        licen.font = UIFont.systemFont(ofSize: 16)
        licen.text = "MIT License"
        
        licen.translatesAutoresizingMaskIntoConstraints = false
        return licen
    }()
    
    // MARK: Hyperlink
    
    lazy var hyperLinkTextView: UITextView = {
        let hyperLink = UITextView()
        
        let atributoString = NSMutableAttributedString(string: "Link do Repositorio")
        let url = URL(string: linkTextView.text)!
        atributoString.setAttributes([.link: url], range: NSMakeRange(0, 19))
        
        
        hyperLink.dataDetectorTypes = .link
        hyperLink.isEditable = false
        hyperLink.isUserInteractionEnabled = true
        hyperLink.attributedText = atributoString
        hyperLink.textAlignment = .center
        hyperLink.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        
        hyperLink.translatesAutoresizingMaskIntoConstraints = false
        
        return hyperLink
        
    }()
    
    lazy var linkTextView: UITextView = {
        let linkTextView = UITextView()
        
        linkTextView.text = "https://www.apple.com"
        
        return linkTextView
    }()
    
    // MARK: Cycle View

    override func viewDidLoad() {
        super.viewDidLoad()
        safeArea = view.layoutMarginsGuide
        
        
        view.addSubview(imageRepoView)
        
        NSLayoutConstraint.activate([
            imageRepoView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            imageRepoView.heightAnchor.constraint(equalToConstant: 300),
            imageRepoView.widthAnchor.constraint(equalToConstant: 300),
            imageRepoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        
        view.addSubview(subTitle)
        
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: imageRepoView.bottomAnchor, constant: 15),
            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(contentAuthorStackView)
        
        NSLayoutConstraint.activate([
            contentAuthorStackView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 15),
            contentAuthorStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
        ])
        
        contentAuthorStackView.addArrangedSubview(iconAutorImageView)
        contentAuthorStackView.addArrangedSubview(autorLabel)
        contentAuthorStackView.addArrangedSubview(nomeAutorLabel)
        
        view.addSubview(contentContStackView)
        
        NSLayoutConstraint.activate([
            contentContStackView.topAnchor.constraint(equalTo: contentAuthorStackView.bottomAnchor, constant: 15),
            contentContStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
        ])
        
        contentContStackView.addArrangedSubview(iconContObs)
        contentContStackView.addArrangedSubview(contObsLabel)
        contentContStackView.addArrangedSubview(quantContLabel)
        
        
        view.addSubview(contentDataStackView)
        
        NSLayoutConstraint.activate([
            contentDataStackView.topAnchor.constraint(equalTo: contentContStackView.bottomAnchor, constant: 15),
            contentDataStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
        ])
        
        contentDataStackView.addArrangedSubview(iconData)
        contentDataStackView.addArrangedSubview(dataLabel)
        contentDataStackView.addArrangedSubview(data)
        
        view.addSubview(contentLicenStackView)
        
        NSLayoutConstraint.activate([
            contentLicenStackView.topAnchor.constraint(equalTo: contentDataStackView.bottomAnchor, constant: 15),
            contentLicenStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
        ])
        
        contentLicenStackView.addArrangedSubview(iconLicen)
        contentLicenStackView.addArrangedSubview(licenLabel)
        contentLicenStackView.addArrangedSubview(licencaLabel)
        
        view.addSubview(hyperLinkTextView)
        
        NSLayoutConstraint.activate([
            hyperLinkTextView.topAnchor.constraint(equalTo: contentLicenStackView.bottomAnchor, constant: 50),
            hyperLinkTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            hyperLinkTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            hyperLinkTextView.heightAnchor.constraint(equalToConstant: 100),
            hyperLinkTextView.widthAnchor.constraint(equalToConstant: 100)
        
        ])
        
        
        view.backgroundColor = .white
        title = nomeRepo
    }// aqui
    
}

