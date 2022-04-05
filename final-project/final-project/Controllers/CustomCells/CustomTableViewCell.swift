//
//  CustomTableViewCell.swift
//  final-project
//
//  Created by Idwall Go Dev 012 on 25/03/22.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    static let identifier:String = "CustomTableViewCell"
   
    lazy private var repoimage: UIImageView = {
        let repoimage = UIImageView()
        repoimage.setDimensions(width: 85, height: 85)
        repoimage.contentMode = .scaleToFill
        repoimage.clipsToBounds = true
        repoimage.layer.cornerRadius = 85/2
        return repoimage
    }()

    lazy private var repoName: UILabel = {
        let repoName = UILabel()
        repoName.font = UIFont.systemFont(ofSize: 17)
        
        return repoName
            
    }()
    
    lazy private var repoDescription: UILabel = {
       let repoDescription = UILabel()
        repoDescription.font = UIFont.systemFont(ofSize: 14)
        repoDescription.numberOfLines = 0
        
        
        
//        repoDescription.backgroundColor = .blue
        
       return repoDescription
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        configureUI()
        //contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
  
    func configureUI(){
        addSubview(repoimage)
        repoimage.centerY(inView: contentView, leftAnchor: leftAnchor,paddingLeft: 7)
        
        let textContiner = UIStackView(arrangedSubviews: [repoName,repoDescription])
        textContiner.axis = .vertical
        addSubview(textContiner)
        
        textContiner.centerY(inView: contentView,leftAnchor: repoimage.rightAnchor,paddingLeft: 15)
        
        
    }
    
    func setup(name:String,description:String, imageUrl:String){
        repoName.text = name
        repoDescription.text = description
        let url = URL(string: imageUrl)
        repoimage.kf.setImage(with: url)
        
    }
}
