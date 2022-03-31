import UIKit

class DevelopersDetilsController: UIViewController {

    private let developerPhone :String
    private let developerEmail :String
    private let developerLinkedin:String
    private let developerTwitter :String
    
    init (developerPhoto:String ,developerName:String, developerPhone: String, developerEmail: String, developerLinkedin: String, developerTwitter: String){
        self.developerPhone = developerPhone
        self.developerEmail = developerEmail
        self.developerLinkedin = developerLinkedin
        self.developerTwitter = developerTwitter
        super.init(nibName: nil, bundle: nil)
        title = developerName
        let url = URL(string: developerPhoto)
        imageRepoView.kf.setImage(with: url)

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
    
    lazy var topicPhone:UIView = {
        let topicPhone = Utilities().createTopicItem(icon: "phone", key: "Telefone: ", value: self.developerPhone)
        return topicPhone
    }()
    
    lazy var topicEmail:UIView = {
        let topicEmail = Utilities().createTopicItem(icon: "envelope", key: "Email: ", value: self.developerEmail)
        return topicEmail
    }()
    
    lazy var topicTwetter:UIView = {
        let topicTwetter = Utilities().createTopicItem(icon: "network", key: "Twetter: ", value: self.developerTwitter)
        return topicTwetter
    }()
    
    lazy var topicLinkedin:UIView = {
        let topicLinkedin = Utilities().createTopicItem(icon: "network", key: "Linkedin: ", value: self.developerLinkedin)
        return topicLinkedin
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

        let topicsStack = UIStackView(arrangedSubviews: [topicEmail,topicPhone,topicTwetter,topicLinkedin])
        topicsStack.axis = .vertical
        topicsStack.spacing = 8
        view.addSubview(topicsStack)
        
        topicsStack.anchor(top: subTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16, paddingLeft: 16, paddingRight: 16)
     
        
  }

    
  
}
