//
//  AlertView.swift
//  ProjectNews
//
//  Created by Luu Hong Son on 9/11/20.
//  Copyright © 2020 VSEE. All rights reserved.
//

import UIKit

class AlertView {
    
    static let shared = AlertView()
    
    private var topViewController: UIViewController {
        return UIViewController().topController()
    }
    
    private var alertController: UIAlertController!

    func presentSimpleAlert(title: String, message: String, buttonTitle: String = "OK", completeHandler: (() -> Void)? = nil) {
        dismisAlertView { [weak self] in
            guard let self = self else { return }
            self.alertController = self.alertView(title: title, message: message, buttonTitle: buttonTitle, completeHandler: completeHandler)
            self.topViewController.present(self.alertController, animated: true)
        }
    }
    
    func dismisAlertView(completeHandler: (() -> Void)? = nil) {
        if alertController != nil {
            alertController.dismiss(animated: false) {
                completeHandler?()
            }
            return
        }
        completeHandler?()
    }
    
    private func alertView(title: String, message: String, buttonTitle: String, completeHandler: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
            completeHandler?()
        }))
        return alert
    }
}
