import Foundation
import UIKit


class Phone {
        
    fileprivate let application = UIApplication.shared
        
    func btnCallClick (_ tel: String) -> Bool {
            
        let flag = self.openPhone(tel)
        return flag
    }
        
        
    private func openPhone(_ tel: String) -> Bool  {
        if let phoneURL = URL(string: "tel://\(tel)"){
            if application.canOpenURL(phoneURL) {
                application.open(phoneURL, options: [:], completionHandler: nil)
                return true
            }
        }
        return false
    }
}
