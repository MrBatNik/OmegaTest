//
//  ViewControllerExtension.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 01.06.2022.
//

import UIKit

extension UIViewController {
    
    func setKeyboardNotification(_ action: Selector, for responder: NSNotification.Name) {
        NotificationCenter.default.addObserver(
            self,
            selector: action,
            name: responder,
            object: nil
        )
    }
    
    func removeKeyboardNotification(_ responder: NSNotification.Name) {
        NotificationCenter.default.removeObserver(
            self,
            name: responder,
            object: nil)
    }
    
}

extension UIViewController {
    
    func showAlert(_ title: String, with message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
    
}
