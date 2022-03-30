
import UIKit
import Kingfisher
import SwiftUI

class RepoViewController: UIViewController {
    
    //MARK: - Properties

    var authorName = ""
    var numberOfViewers = ""
    var createdAt = ""
    var license = ""
    var repoLink = ""
    
    func setup(nomeRepo:String, imagem: String, nomeAutor: String, contObservadores: String, dataCriacao: String, licenca: String, link: String) {
        title = nomeRepo
        let url = URL(string: imagem)
        imageRepoView.kf.setImage(with: url)
        self.authorName = nomeAutor
        self.numberOfViewers = contObservadores
        self.createdAt = dataCriacao
        self.license = licenca
        self.repoLink = link
    }
    
    var safeArea: UILayoutGuide!
    static let identifier = "RepoViewCell"
           
    lazy var imageRepoView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "stop")
        image.tintColor = .black
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.textColor = .black
        subTitle.numberOfLines = 0
        subTitle.font = UIFont.systemFont(ofSize: 17)
        subTitle.text = "A curated list of awesome iOS ecosystem, including Objective-c and Swift Projects"
        return subTitle
    }()
    
    
    lazy var topicAuthor:UIView = {
        let userOwner = createTopicItem(icon: "person.crop.square", key: "Autor: ", value: self.authorName)
        return userOwner
    }()
    
    lazy var topicViewers:UIView = {
        var viewersValue = ""
        let userOwner = createTopicItem(icon: "eye", key: "Contagem de Observadores: ", value: self.numberOfViewers)
        return userOwner
    }()
    lazy var topicCreatedAt:UIView = {
        var createdAtValue = ""
        let userOwner = createTopicItem(icon: "alarm.fill", key: "Data de criação: ", value: self.createdAt)
        return userOwner
    }()
    lazy var topicLicense:UIView = {
        var licenseValue = ""
        let userOwner = createTopicItem(icon: "globe", key: "Licença: ", value: self.license)
        return userOwner
    }()
    
    lazy var hyperLinkTextView: UITextView = {
        let hyperLink = UITextView()
        let atributoString = NSMutableAttributedString(string: "Link do Repositorio")
        let url = URL(string: self.repoLink)!
        atributoString.setAttributes([.link: url], range: NSMakeRange(0, 19))
        hyperLink.dataDetectorTypes = .link
        hyperLink.isEditable = false
        hyperLink.isUserInteractionEnabled = true
        hyperLink.attributedText = atributoString
        hyperLink.textAlignment = .center
        hyperLink.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        hyperLink.linkTextAttributes = [
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return hyperLink

    }()
    
//    lazy var contentAuthorStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 10
//        stack.contentMode = .center
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        return stack
//
//    }()
//
//    // MARK: Autor
//
//    lazy var iconAutorImageView: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(systemName: "person.crop.square")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.tintColor = .black
//
//        return image
//    }()
//
//    lazy var autorLabel: UILabel = {
//        let autor = UILabel()
//       // let stringAutor = UILabel()
//       // let nomeAutor = UILabel()
//
//        autor.font = UIFont.boldSystemFont(ofSize: 16)
//        //autor.text = "  Autor: \(nomeAutorLabel.text!)"
//        autor.text = "  Autor:"
//
//
////        stringAutor.font = UIFont.systemFont(ofSize: 12)
////        stringAutor.text = "Nome do autor"
////
////        autor.text = nomeAutor.text! + stringAutor.text!
//        autor.translatesAutoresizingMaskIntoConstraints = false
//
//        return autor
//
//
//    }()
//
//    lazy var nomeAutorLabel: UILabel = {
//        let nomeAutor = UILabel()
//        nomeAutor.font = UIFont.systemFont(ofSize: 16)
//        nomeAutor.text = "Nome do Autor"
//        nomeAutor.numberOfLines = 0
//
//        nomeAutor.translatesAutoresizingMaskIntoConstraints = false
//
//        return nomeAutor
//    }()
//
//
//    // MARK: Quantidade de visualização
//
//    lazy var contentContStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 10
//        stack.contentMode = .center
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        return stack
//
//    }()
//
//    lazy var iconContObs: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(systemName: "eye")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.tintColor = .black
//
//        return image
//    }()
//
//    lazy var contObsLabel: UILabel = {
//        let contObs = UILabel()
//       // let stringCont = UILabel()
//        //let quantCont = UILabel()
//        contObs.font = UIFont.boldSystemFont(ofSize: 16)
//        contObs.text = "Contagem de observadores:"
//        contObs.translatesAutoresizingMaskIntoConstraints = false
//
//        return contObs
//
//
//    }()
//
//    lazy var quantContLabel: UILabel = {
//        let quantCont = UILabel()
//        quantCont.font = UIFont.systemFont(ofSize: 16)
//        quantCont.text = "00000"
//        quantCont.translatesAutoresizingMaskIntoConstraints = false
//        return quantCont
//
//
//    }()
//
//    // MARK: Data
//
//    lazy var contentDataStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 10
//        stack.contentMode = .center
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        return stack
//
//    }()
//
//    lazy var iconData: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(systemName: "alarm.fill")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.tintColor = .black
//
//        return image
//    }()
//
//    lazy var dataLabel: UILabel = {
//        let dataCriacao = UILabel()
//        dataCriacao.font = UIFont.boldSystemFont(ofSize: 16)
//        dataCriacao.text = "  Data de criação:"
//        dataCriacao.translatesAutoresizingMaskIntoConstraints = false
//
//        return dataCriacao
//
//
//    }()
//
//    lazy var data: UILabel = {
//        let data = UILabel()
//
//        data.font = UIFont.systemFont(ofSize: 16)
//        data.text = "00/00/0000"
//
//        data.translatesAutoresizingMaskIntoConstraints = false
//
//        return data
//
//
//    }()
//
//    // MARK: Licença
//
//    lazy var contentLicenStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 10
//        stack.contentMode = .center
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        return stack
//
//    }()
//
//    lazy var iconLicen: UIImageView = {
//        let image = UIImageView()
//        image.image = UIImage(systemName: "globe")
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.tintColor = .black
//
//        return image
//    }()
//
//    lazy var licenLabel: UILabel = {
//        let licencaProject = UILabel()
//        licencaProject.font = UIFont.boldSystemFont(ofSize: 16)
//        licencaProject.text = "  Licença:"
//        licencaProject.translatesAutoresizingMaskIntoConstraints = false
//
//        return licencaProject
//
//    }()
//
//    lazy var licencaLabel: UILabel = {
//        let licen = UILabel()
//
//        licen.font = UIFont.systemFont(ofSize: 16)
//        licen.text = "MIT License"
//
//        licen.translatesAutoresizingMaskIntoConstraints = false
//        return licen
//    }()
//
//
   
//
//    lazy var linkTextView: UITextView = {
//        let linkTextView = UITextView()
//
//        linkTextView.text = "https://www.apple.com"
//
//        return linkTextView
//    }()
//
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }
    //MARK: - Helpers

    func createTopicItem (icon:String, key:String, value:String)->UIView{
        let topicItem = UIView()
        topicItem.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        let imageicon = UIImageView()
        imageicon.image = UIImage(systemName: icon)
        topicItem.addSubview(imageicon)
        imageicon.anchor( left: topicItem.leftAnchor, bottom: topicItem.bottomAnchor,paddingLeft: 4, paddingBottom: 4)
        imageicon.setDimensions(width: 21, height: 21)
        imageicon.tintColor = .black

        
        let label = UILabel()
        topicItem.addSubview(label)
        let labelValue = NSMutableAttributedString(string: key,attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize:17),NSAttributedString.Key.foregroundColor:UIColor.black])
        
        labelValue.append(NSAttributedString(string: value,attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor:UIColor.black ]))
        
        label.textColor = .black
        label.attributedText = labelValue
        label.anchor( left: imageicon.rightAnchor, bottom: topicItem.bottomAnchor, right:topicItem.rightAnchor, paddingLeft: 16, paddingBottom: 4)

    
        return topicItem
    }
    
    func configureUI(){
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .white
        
        view.addSubview(imageRepoView)
        imageRepoView.centerX(inView: view,topAnchor: view.safeAreaLayoutGuide.topAnchor,paddingTop: 20)
        imageRepoView.setDimensions(width: 200, height: 150)

        view.addSubview(subTitle)
        subTitle.anchor(top: imageRepoView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 23, paddingLeft: 21, paddingRight: 21)

        let topicsStack = UIStackView(arrangedSubviews: [topicAuthor,topicViewers,topicCreatedAt,topicLicense])
        topicsStack.axis = .vertical
        topicsStack.spacing = 8
        view.addSubview(topicsStack)
        
        topicsStack.anchor(top: subTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16, paddingLeft: 16, paddingRight: 16)
     
        view.addSubview(hyperLinkTextView)

        hyperLinkTextView.anchor(top:topicsStack.bottomAnchor, left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingTop: 50)
        
        
        //        NSLayoutConstraint.activate([
        //            subTitle.topAnchor.constraint(equalTo: imageRepoView.bottomAnchor, constant: 15),
        //            subTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        //            subTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        //        ])
                
//        NSLayoutConstraint.activate([
//            imageRepoView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
//            imageRepoView.heightAnchor.constraint(equalToConstant: 300),
//            imageRepoView.widthAnchor.constraint(equalToConstant: 300),
//            imageRepoView.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
//
//        view.addSubview(contentAuthorStackView)
//
//        NSLayoutConstraint.activate([
//            contentAuthorStackView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 15),
//            contentAuthorStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
//        ])
//
//        contentAuthorStackView.addArrangedSubview(iconAutorImageView)
//        contentAuthorStackView.addArrangedSubview(autorLabel)
//        contentAuthorStackView.addArrangedSubview(nomeAutorLabel)
//
//        view.addSubview(contentContStackView)
//
//        NSLayoutConstraint.activate([
//            contentContStackView.topAnchor.constraint(equalTo: contentAuthorStackView.bottomAnchor, constant: 15),
//            contentContStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
//        ])
//
//        contentContStackView.addArrangedSubview(iconContObs)
//        contentContStackView.addArrangedSubview(contObsLabel)
//        contentContStackView.addArrangedSubview(quantContLabel)
//
//
//        view.addSubview(contentDataStackView)
//
//        NSLayoutConstraint.activate([
//            contentDataStackView.topAnchor.constraint(equalTo: contentContStackView.bottomAnchor, constant: 15),
//            contentDataStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
//        ])
//
//        contentDataStackView.addArrangedSubview(iconData)
//        contentDataStackView.addArrangedSubview(dataLabel)
//        contentDataStackView.addArrangedSubview(data)
//
//
//
//        view.addSubview(contentLicenStackView)
//
//        NSLayoutConstraint.activate([
//            contentLicenStackView.topAnchor.constraint(equalTo: contentDataStackView.bottomAnchor, constant: 15),
//            contentLicenStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8)
//        ])
//
//        contentLicenStackView.addArrangedSubview(iconLicen)
//        contentLicenStackView.addArrangedSubview(licenLabel)
//        contentLicenStackView.addArrangedSubview(licencaLabel)
//
//
//        NSLayoutConstraint.activate([
//            hyperLinkTextView.topAnchor.constraint(equalTo: contentLicenStackView.bottomAnchor, constant: 50),
//            hyperLinkTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//            hyperLinkTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            hyperLinkTextView.heightAnchor.constraint(equalToConstant: 100),
//            hyperLinkTextView.widthAnchor.constraint(equalToConstant: 100)
//
//        ])
//
//
//
  }
    
    
}
