import UIKit

class UserDeveloperTableViewCell: UITableViewCell {
    static let identifier = "ToDoTableViewCell"
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
    
        imageView.layer.cornerRadius = 70 / 2
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        
        iconView.image = UIImage(systemName: "chevron.right")
        iconView.tintColor = .label
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconView
    }()
    
    lazy var nameDeveloper: UILabel = {
        let name = UILabel()
        
        name.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        name.textColor = .label
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
    }()
    
    lazy var textOccupation: UILabel = {
        let occupation = UILabel()
        
        occupation.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        occupation.textColor = .label
        occupation.translatesAutoresizingMaskIntoConstraints = false
        
        return occupation
    }()
    
    lazy var stackVertical: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .top
        stack.spacing = -12
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImage)
        
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(stackVertical)
        
        NSLayoutConstraint.activate([
            stackVertical.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackVertical.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 16),
            stackVertical.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            stackVertical.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        
        addSubview(iconView)
        
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            iconView.leadingAnchor.constraint(equalTo: stackVertical.trailingAnchor,  constant: 16),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        
        stackVertical.addArrangedSubview(nameDeveloper)
        stackVertical.addArrangedSubview(textOccupation)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: DataDevelopers){
        
        nameDeveloper.text = data.name
        textOccupation.text = data.occupation
       
        let url = URL(string: data.profile)
        profileImage.kf.setImage(with: url)
    }
}
