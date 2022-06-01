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
        
//        NotificationCenter.default.removeObserver(
//            self,
//            name: UIResponder.keyboardWillHideNotification,
//            object: nil)
    }
    
}
