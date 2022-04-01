
import UIKit
import Kingfisher
import SwiftUI

class RepoDetailsController: UIViewController {
    
    //MARK: - Properties

    private let authorName:String
    private let numberOfViewers :String
    private let createdAt :String
    private let license:String
    private let repoLink :String
    
    init (item: FavoriteRepo){
        self.authorName = item.authorName
        self.numberOfViewers =  "\(item.watchersCount)"
        self.createdAt = item.createdAt
        self.license = item.license
        self.repoLink = item.url
        super.init(nibName: nil, bundle: nil)
        title = item.name
        let url = URL(string: item.avatarURL)
        imageRepoView.kf.setImage(with: url)

    }
    
    private func saveFavorite(item: FavoriteRepo) {
        
        ManagedObjectContext.shared.save(item: item) { result in
            switch result {
            case .Success:
                print("sucesso")
            case .Error(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        let userOwner = Utilities().createTopicItem(icon: "person.crop.square", key: "Autor: ", value: self.authorName)
        return userOwner
    }()
    
    lazy var topicViewers:UIView = {
        var viewersValue = ""
        let userOwner = Utilities().createTopicItem(icon: "eye", key: "Contagem de Observadores: ", value: self.numberOfViewers)
        return userOwner
    }()
    
    lazy var topicCreatedAt:UIView = {
        var createdAtValue = ""
        let userOwner = Utilities().createTopicItem(icon: "alarm.fill", key: "Data de criação: ", value: self.createdAt)
        return userOwner
    }()
    
    lazy var topicLicense:UIView = {
        var licenseValue = ""
        let userOwner = Utilities().createTopicItem(icon: "globe", key: "Licença: ", value: self.license)
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
       
    }
    
    //MARK: - Helpers
    
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
        
  }

}
