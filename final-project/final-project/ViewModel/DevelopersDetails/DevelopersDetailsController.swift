import UIKit
import SafariServices
import MessageUI

class DevelopersDetailsController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private let viewModel: DevelopersDetailsViewModel = DevelopersDetailsViewModel()
    
    var safeArea: UILayoutGuide!
    
    static let identifier = "RepoViewCell"
    
    // MARK: - View components
    lazy var topicPhone:UIView = {
        let topicPhone = Utilities().createTopicItemWithButton(icon: "phone", key: "Telefone: ", value: viewModel.developer?.phone ?? "", button: buttonPhone)
        return topicPhone
    }()

    lazy var topicEmail:UIView = {
        let topicEmail = Utilities().createTopicItemWithButton(icon: "envelope", key: "Email: ", value: viewModel.developer?.email ?? "", button: buttonEmail)
        return topicEmail
    }()

    lazy var topicTwetter:UIView = {
        let topicTwetter = Utilities().createTopicItemWithButton(icon: "network", key: "Twitter: ", value: viewModel.developer?.twitter ?? "", button: buttonTwitter)
        return topicTwetter
    }()

    lazy var topicLinkedin:UIView = {
        let topicLinkedin = Utilities().createTopicItemWithButton(icon: "network", key: "Linkedin: ", value: viewModel.developer?.linkedin ?? "", button: buttonLinkedin)
        return topicLinkedin
    }()
    
    
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
        subTitle.text = viewModel.developer?.name ?? ""
        return subTitle
    }()
    
    lazy var buttonPhone: UIButton = {
        buttonPhone = UIButton(type: .custom)
        buttonPhone.setTitle(viewModel.developer?.phone ?? "", for: .normal)
        buttonPhone.setTitleColor(UIColor.black, for: .normal)
        buttonPhone.backgroundColor = .white
        buttonPhone.isUserInteractionEnabled = true
        buttonPhone.addTarget(self, action:  #selector(buttonActionPhone), for: .touchUpInside)
   
   
        return buttonPhone
    
    }()
    
    lazy var buttonLinkedin: UIButton = {
        buttonLinkedin = UIButton(type: .custom)
        buttonLinkedin.setTitle(viewModel.developer?.linkedin ?? "", for: .normal)
        buttonLinkedin.setTitleColor(UIColor.black, for: .normal)
        buttonLinkedin.backgroundColor = .white
        buttonLinkedin.isUserInteractionEnabled = true
        buttonLinkedin.titleLabel?.numberOfLines = 0
        buttonLinkedin.addTarget(self, action:  #selector(buttonActionLinkedin), for: .touchUpInside)
   
        return buttonLinkedin
    
    }()
        
    lazy var buttonEmail: UIButton = {
        buttonEmail = UIButton(type: .custom)
        buttonEmail.setTitle(viewModel.developer?.email ?? "", for: .normal)
        buttonEmail.setTitleColor(UIColor.black, for: .normal)
        buttonEmail.backgroundColor = .white
        buttonEmail.isUserInteractionEnabled = true
        buttonEmail.addTarget(self, action:  #selector(buttonActionEmail), for: .touchUpInside)
   
        return buttonEmail
    
    }()
    
    lazy var buttonTwitter: UIButton = {
        
        buttonTwitter = UIButton(type: .custom)
        buttonTwitter.setTitle(viewModel.developer?.twitter ?? "", for: .normal)
        buttonTwitter.setTitleColor(UIColor.black, for: .normal)
        buttonTwitter.backgroundColor = .white
        buttonTwitter.isUserInteractionEnabled = true
        buttonTwitter.addTarget(self, action:  #selector(buttonActionTwitter), for: .touchUpInside)
   
        return buttonTwitter
    
    }()
    
    init (developer: Developers){
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
        
        viewModel.developer = developer;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.developer?.name ?? ""
        
        let url = URL(string: viewModel.developer?.profile ?? "")
        
        imageRepoView.kf.setImage(with: url)
        configureUI()
        
    }

    // MARK: - Binders
    @objc func buttonActionEmail(sender: UIButton!) {
        viewModel.sendMail(email: viewModel.developer?.email ?? "")
    }
    
    @objc func buttonActionPhone(sender: UIButton!) {
        viewModel.callPhone()
    }
    
    @objc func buttonActionTwitter(sender: UIButton!) {
        viewModel.openUrl(url: viewModel.developer?.twitter ?? "")
    }
        
    @objc func buttonActionLinkedin(sender: UIButton!) {
        viewModel.openUrl(url: viewModel.developer?.linkedin ?? "")
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
        
        if (viewModel.developer?.twitter != "") {
            let topicsStack = UIStackView(arrangedSubviews: [topicPhone,topicEmail,topicLinkedin,topicTwetter])
            
            topicsStack.axis = .vertical
            topicsStack.spacing = 8
            view.addSubview(topicsStack)
            
            topicsStack.anchor(top: subTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16, paddingLeft: 16, paddingRight: 16)
            
        } else {
            let topicsStack = UIStackView(arrangedSubviews: [topicPhone,topicEmail,topicLinkedin])
            topicsStack.axis = .vertical
            topicsStack.spacing = 8
            view.addSubview(topicsStack)
            
            topicsStack.anchor(top: subTitle.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor,paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        }
    }
    
    private func showAlertError(_ message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Erro", style: .default, handler: { _ in }))
        
        present(alert, animated: true, completion: nil)
    }
}

extension DevelopersDetailsController: DevelopersDetailsDelegate {
    func showView(viewController: UIViewController) {
        present(viewController, animated: true)
    }
    
    func callActionFail(_ error: String) {
        showAlertError(error)
    }
}

