//
//  Utilities.swift
//  final-project
//
//  Created by Idwall Go Dev 012 on 29/03/22.
//

import UIKit

class Utilities {
    
    fileprivate let application = UIApplication.shared
    private var values:String = ""
    
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
    
    func createTopicItemWithButton(icon:String, key:String, value:String, button:UIButton)->UIView{
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
        label.font = UIFont.boldSystemFont(ofSize:17)
        label.text = key
        label.textColor = .black

        label.anchor( left: imageicon.rightAnchor, bottom: topicItem.bottomAnchor, paddingLeft: 16, paddingBottom: 4)
        
    
        
        values = value
        topicItem.addSubview(button)
        button.anchor(left: label.rightAnchor, paddingLeft: 4, paddingBottom: 0)
        
        return topicItem
    }
}

