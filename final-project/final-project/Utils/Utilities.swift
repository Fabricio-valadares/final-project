    
import UIKit

class Utilities {
    func createTopicItem (icon:String, key:String, value:String)->UIView{
        let topicItem = UIView()
        //topicItem.backgroundColor = .orange
        print(topicItem.frame.size.height)
        topicItem.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        //topicItem.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let imageicon = UIImageView()
        imageicon.image = UIImage(systemName: icon)
        topicItem.addSubview(imageicon)
        //imageicon.anchor( left: topicItem.leftAnchor, bottom: topicItem.bottomAnchor,paddingLeft: 4, paddingBottom: 4)
        imageicon.setDimensions(width: 21, height: 21)
        imageicon.centerY(inView: topicItem, leftAnchor: topicItem.leftAnchor, paddingLeft:  4, constant: 0)
        imageicon.tintColor = .black
        //imageicon.backgroundColor =

        
        let label = UILabel()
        topicItem.addSubview(label)
        let labelValue = NSMutableAttributedString(string: key,attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize:17),NSAttributedString.Key.foregroundColor:UIColor.black])
        
        labelValue.append(NSAttributedString(string: value,attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 17),NSAttributedString.Key.foregroundColor:UIColor.black ]))
        
        label.textColor = .black
        label.attributedText = labelValue
        label.numberOfLines = 2
        label.textAlignment =  .left
        label.trailingAnchor.constraint(equalTo: topicItem.trailingAnchor).isActive = true
        //label.anchor( left: imageicon.rightAnchor, bottom: topicItem.bottomAnchor, right:topicItem.rightAnchor, paddingLeft: 16, paddingBottom: 4)
        label.centerY(inView: topicItem, leftAnchor: imageicon.rightAnchor, paddingLeft:  16, constant: 0)

    
        return topicItem
    }
    
    private var values: String = ""
    
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
            button.anchor(left: label.rightAnchor, paddingLeft: 4, paddingBottom: 10)
            button.titleLabel?.lineBreakMode = .byClipping
            button.titleLabel?.baselineAdjustment = .alignBaselines
            
            
            return topicItem
        }
    
    func DateFormater(date:String) -> String{

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        let formatedDate = "\(String(describing: dateFormatter.date(from: date)))"

        print("date: \(date)")
        
        return formatedDate
    }
}
