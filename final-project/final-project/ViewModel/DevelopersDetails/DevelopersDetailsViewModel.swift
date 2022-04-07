//
//  DevelopersDetailsViewModel.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import SafariServices
import MessageUI

class DevelopersDetailsViewModel {
    public var delegate: DevelopersDetailsDelegate?
    
    public var developer: Developers?
    
    fileprivate let application = UIApplication.shared
    
    func callPhone() {
        if(!Phone().callPhone(developer?.phone ?? "")) {
            delegate?.callActionFail("O telefone não pode ser aberto")
        }
    }
    
    func sendMail(email: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients([email])
            mail.setMessageBody("<p>Obrigada Doug e Idwall!!!</p>", isHTML: true)

            delegate?.showView(viewController: mail)
        } else {
            delegate?.callActionFail("O email não pode ser enviado")
        }
    }
    
    func openUrl(url: String) {
        if let url = URL(string: url) {
            
            if(application.canOpenURL(url)) {
            
                let config = SFSafariViewController.Configuration()
        
                let safariViewController = SFSafariViewController(url: url, configuration: config)
            
                safariViewController.preferredControlTintColor = .black
                safariViewController.preferredBarTintColor = .systemGray
                safariViewController.dismissButtonStyle = .close
              
                delegate?.showView(viewController: safariViewController)
            } else {
                delegate?.callActionFail("A url não pode ser aberta")
            }
        } else {
            delegate?.callActionFail("A url não é válida")
        }
    }
}
