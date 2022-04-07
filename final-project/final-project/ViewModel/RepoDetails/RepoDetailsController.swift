
import UIKit
import Kingfisher
import SwiftUI

class RepoDetailsController: UIViewController {
    
    //MARK: - Properties
    var safeArea: UILayoutGuide!
    
    static let identifier = "RepoViewCell"

    private let viewModel: RepoDetailsViewModel = RepoDetailsViewModel()
  
    private var favoriteButton: UIBarButtonItem?
    
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
        let userOwner = Utilities().createTopicItem(icon: "person.crop.square", key: "Autor: ", value: viewModel.repository?.authorName ?? "")
        return userOwner
    }()
    
    lazy var topicViewers:UIView = {
        let userOwner = Utilities().createTopicItem(icon: "eye", key: "Contagem de Observadores: ", value: "\(viewModel.repository?.watchersCount ?? 0)")
        return userOwner
    }()
    
    lazy var topicCreatedAt:UIView = {
        let userOwner = Utilities().createTopicItem(icon: "alarm.fill", key: "Data de criação: ", value: viewModel.repository?.createdAt ?? "")
        return userOwner
    }()
    
    lazy var topicLicense:UIView = {
        let userOwner = Utilities().createTopicItem(icon: "globe", key: "Licença: ", value: viewModel.repository?.license ?? "")
        return userOwner
    }()
    
    lazy var hyperLinkTextView: UITextView = {
        let hyperLink = UITextView()
        let atributoString = NSMutableAttributedString(string: "Link do Repositorio")
        let url = URL(string: viewModel.repository?.url ?? "")!
        atributoString.setAttributes([.link: url], range: NSMakeRange(0, 19))
        hyperLink.dataDetectorTypes = .link
        hyperLink.isEditable = false
        hyperLink.isUserInteractionEnabled = true
        hyperLink.attributedText = atributoString
        hyperLink.textAlignment = .center
        hyperLink.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        hyperLink.linkTextAttributes = [
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        return hyperLink

    }()

    
    init (item: Repository){
        super.init(nibName: nil, bundle: nil)
        
        viewModel.repository = item
        
        viewModel.delegate = self
        
        title = viewModel.repository?.name ?? ""
        
        let url = URL(string: viewModel.repository?.avatarURL ?? "")
        
        imageRepoView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.getMappedToIdFavoritedRepositories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setFavoriteButton()
    }
    
    //MARK: - Binders
    @IBAction func favoriteItem() {
        viewModel.favoriteItem()
    }
    
    @IBAction func unFavoriteItem() {
        viewModel.unfavoriteItem()
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
        view.addSubview(topicsStack)
        
        topicsStack.anchor(top: subTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16, paddingLeft: 16, paddingRight: 16)
     
        view.addSubview(hyperLinkTextView)

        hyperLinkTextView.anchor(top:topicsStack.bottomAnchor, left: view.leftAnchor,bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingTop: 50)
        
  }

    private func showAlertError(_ message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Erro", style: .default, handler: { action in
                    //Fazer algo se necessario
                }))
        
        present(alert, animated: true, completion: nil)
    }
  
    private func setFavoriteButton() {
          let icon = viewModel.isFavorited ? "heart.fill" : "heart"
        
          let action = viewModel.isFavorited ? #selector(unFavoriteItem) : #selector(favoriteItem)
      
          favoriteButton = UIBarButtonItem(image: UIImage(systemName: icon), style: .plain, target: self, action: action)
          
          favoriteButton?.tintColor = .black
        
          navigationItem.rightBarButtonItem = favoriteButton
    }

}

extension RepoDetailsController: RepoDetailsDelegate {
    func favoriteUpdateFavorite() {
        setFavoriteButton()
    }
    
    func favoriteUpdateFavoriteError(_ error: String) {
        showAlertError(error)
    }
}
