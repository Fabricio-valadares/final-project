
import UIKit

class ShowDeveloperContactViewController: UIViewController {
    
    private var safeArea: UILayoutGuide!
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 70 / 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var content: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Fale um pouco sobre você."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // ----
    
    lazy var icon: UIImageView = {
        let iconView = UIImageView()
    
        iconView.image = UIImage(systemName: "books.vertical.circle.fill")
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconView
    }()
    
    lazy var textOccupation: UILabel = {
        let occupation = UILabel()
        
        occupation.text = "shshhjsajhjhahahja"
        occupation.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        occupation.textColor = .label
        occupation.translatesAutoresizingMaskIntoConstraints = false
        
        return occupation
    }()
    
    lazy var stackHorizontal: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .top
        stack.backgroundColor = .brown
        stack.spacing = -12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    lazy var stackVertical: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .top
        stack.backgroundColor = .green
        stack.spacing = -12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //----
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let url = URL(string: "https://bit.ly/3uwlqcf")
        self.iconImageView.kf.setImage(with: url)
        
        safeArea = view.layoutMarginsGuide
        addSubviews()
        configureIconImageView()
        configureContent()
        configureStackVertical()
        configureStackHorizontal()
    }
    
    private func addSubviews() {
        view.addSubviews(iconImageView, descriptionLabel, content, stackVertical, stackHorizontal)
        
        content.addSubview(descriptionLabel)
        stackVertical.addSubview(stackHorizontal)
        
    }
    
    private func configureIconImageView() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 180),
            iconImageView.widthAnchor.constraint(equalToConstant: 180),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureContent() {
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20),
            content.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureStackVertical() {
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 20),
            stackVertical.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stackVertical.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    private func configureStackHorizontal() {
        NSLayoutConstraint.activate([
            stackHorizontal.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 20),
            stackHorizontal.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            stackHorizontal.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
//            stackHorizontal.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -30),
//            stackHorizontal.heightAnchor.constraint(equalToConstant: 180),
//            stackHorizontal.widthAnchor.constraint(equalToConstant: 180),
            
        ])
        
        stackHorizontal.addArrangedSubview(icon)
        stackHorizontal.addArrangedSubview(textOccupation)
    }
}

extension UIView {
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
