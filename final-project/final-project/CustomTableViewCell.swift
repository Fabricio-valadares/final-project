//
//  CustomTableViewCell.swift
//  final-project
//
//  Created by Idwall Go Dev 012 on 25/03/22.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    static let idetifier:String = "CustomTableViewCell"
   
    lazy private var repoimage: UIImageView = {
       let  repoimage = UIImageView()
        
        return repoimage
    }()

    lazy private var repoName: UILabel = {
       let  repoimage = UILabel()
            return repoimage
    }()
    
    lazy private var repoDescription: UILabel = {
       let  repoimage = UILabel()
        return repoimage
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        contentView.backgroundColor = .orange
        contentView.addSubview(repoimage)
        contentView.addSubview(repoName)
        contentView.addSubview(repoDescription)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        repoName.frame = CGRect(x: 8, y: 8, width: contentView.frame.size.width, height: (contentView.frame.size.height/2))
        repoDescription.frame = CGRect(x:8 , y: 16, width: contentView.frame.size.width, height: (contentView.frame.size.height/2))
        repoimage.frame = CGRect(x: 8, y: 8, width: contentView.frame.size.width, height: (contentView.frame.size.height/2))

    }
    
    func setup(with model: Item){

        repoName.text = model.name
        repoDescription.text = model.owner.login
        let url = URL(string: model.owner.avatarURL)
        repoimage.kf.setImage(with: url)
        
    }
}
