import UIKit
import SafariServices
import MessageUI

class DevelopersDetilsController: UIViewController, MFMailComposeViewControllerDelegate {
    
    private let developerPhone :String
    private let developerEmail :String
    private let developerLinkedin:String
    private let developerTwitter :String
    private let developerDescription : String
    private let developerName:String
    
    init (developerPhoto:String ,developerName:String, developerPhone: String, developerEmail: String, developerLinkedin: String, developerTwitter: String, developerDescription: String){
        self.developerPhone = developerPhone
        self.developerEmail = developerEmail
        self.developerLinkedin = developerLinkedin
        self.developerTwitter = developerTwitter
        self.developerDescription = developerDescription
        self.developerName = developerName
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
        subTitle.text = self.developerDescription
        return subTitle
    }()
    
    lazy var buttonPhone: UIButton = {
       let buttonPhone = UIButton(type: .custom)
        buttonPhone.setTitle(self.developerPhone, for: .normal)
        buttonPhone.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonPhone.setTitleColor(UIColor.black, for: .normal)
        buttonPhone.backgroundColor = .white
        buttonPhone.isUserInteractionEnabled = true
        buttonPhone.addTarget(self, action:  #selector(buttonActionPhone), for: .touchUpInside)
   
   
    return buttonPhone
    
}()
    
    @objc func buttonActionPhone(sender: UIButton!) {
        let flag = Phone().btnCallClick(developerPhone)
        alert(flag: flag)
    
       print("Button Phone")
    }
    
    lazy var buttonEmail: UIButton = {
        let buttonEmail = UIButton(type: .custom)
        buttonEmail.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonEmail.setTitle(self.developerEmail, for: .normal)
        buttonEmail.setTitleColor(UIColor.black, for: .normal)
        buttonEmail.backgroundColor = .white
        buttonEmail.isUserInteractionEnabled = true
        buttonEmail.addTarget(self, action:  #selector(buttonActionEmail), for: .touchUpInside)
   
   
    return buttonEmail
    
}()
    
    @objc func buttonActionEmail(sender: UIButton!) { //OLHAR
      sendEmail(developerEmail)
      print("Button Email")
    }
    
    lazy var buttonTwitter: UIButton = {
       let  buttonTwitter = UIButton(type: .custom)
        var nameUser = validate(developerTwitter)
        buttonTwitter.titleLabel?.adjustsFontSizeToFitWidth = true
        buttonTwitter.titleLabel?.numberOfLines = 2
        buttonTwitter.setTitle(nameUser, for: .normal)
        buttonTwitter.setTitleColor(UIColor.black, for: .normal)
        buttonTwitter.backgroundColor = .white
        buttonTwitter.isUserInteractionEnabled = true
        buttonTwitter.addTarget(self, action:  #selector(buttonActionTwitter), for: .touchUpInside)
        
   
   
    return buttonTwitter
    
}()

    
    @objc func buttonActionTwitter(sender: UIButton!) {
      callSafari(developerTwitter)
      print("Button Twitter")
    }
    
    lazy var buttonLinkedin: UIButton = {
        let buttonLinkedin = UIButton(type: .custom)
        buttonLinkedin.setTitle(self.developerName, for: .normal)
        buttonLinkedin.setTitleColor(UIColor.black, for: .normal)
        buttonLinkedin.backgroundColor = .white
        buttonLinkedin.isUserInteractionEnabled = true
        buttonLinkedin.titleLabel?.numberOfLines = 0
        buttonLinkedin.addTarget(self, action:  #selector(buttonActionLinkedin), for: .touchUpInside)
   
   
    return buttonLinkedin
    
}()
    
    @objc func buttonActionLinkedin(sender: UIButton!) {
      callSafari(developerLinkedin)
      print("Button Linkedin")
    }
    
    lazy var topicPhone:UIView = {
        let topicPhone = Utilities().createTopicItemWithButton(icon: "phone", key: "Telefone: ", value: self.developerPhone, button: buttonPhone)
        return topicPhone
    }()

    lazy var topicEmail:UIView = {
        let topicEmail = Utilities().createTopicItemWithButton(icon: "envelope", key: "Email: ", value: self.developerEmail, button: buttonEmail)
        return topicEmail
    }()

    lazy var topicTwetter:UIView = {
        let topicTwetter = Utilities().createTopicItemWithButton(icon: "network", key: "Twitter: ", value: self.developerTwitter, button: buttonTwitter)
        return topicTwetter
    }()

    lazy var topicLinkedin:UIView = {
        let topicLinkedin = Utilities().createTopicItemWithButton(icon: "network", key: "Linkedin: ", value: self.developerLinkedin, button: buttonLinkedin)
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
        
        if (self.developerTwitter != "") {
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
    
    // MARK: - Call Button
    
   private func sendEmail(_ email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setMessageBody("<p>Obrigada Doug, Idwall e Gama!!!</p>", isHTML: true)

            present(mail, animated: true)
        } else {
           alert(flag: false)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    private func callSafari(_ url: String) {
        if let url = URL(string: url) {
            
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable
            
            let DevelopersDetilsController = SFSafariViewController(url: url, configuration: config)
            DevelopersDetilsController.delegate = self
            DevelopersDetilsController.preferredControlTintColor = .black
            DevelopersDetilsController.preferredBarTintColor = .systemGray
            DevelopersDetilsController.dismissButtonStyle = .close
            present(DevelopersDetilsController, animated: true)
        }
    }
    
    // MARK: - Validation url
    
    func validate(_ urlString: String) -> String {
            if let url = URL(string: developerTwitter),
               url.isFileURL || (url.host != nil && url.scheme != nil) {
                let user = urlString.split(separator: "/")
                return "@\(user[2])"
            }
            return urlString
        }
    
    
    private func alert(flag: Bool) {
        
        if flag == false {
        var dialogMessage = UIAlertController(title: "Erro", message: "Não é possível executar essa ação no simulador", preferredStyle: .alert)
        let noPossibleCall = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(noPossibleCall)
        self.present(dialogMessage, animated: true, completion: nil)}
    }
    
    private func alertLink(flag: Bool) {
        
        if flag == false {
        var dialogMessage = UIAlertController(title: "Erro", message: "URL Inváilida", preferredStyle: .alert)
        let noPossibleCall = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(noPossibleCall)
        self.present(dialogMessage, animated: true, completion: nil)}
    }
}

// MARK: - Extension

extension DevelopersDetilsController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true) {
            print("Fazer alguma coisa")
        }
    }
    
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        
            print("didCompleteInitialLoad \(didLoadSuccessfully)")
    }
}

