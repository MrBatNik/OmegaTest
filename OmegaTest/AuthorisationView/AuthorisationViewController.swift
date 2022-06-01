//
//  AuthorisationViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

class AuthorisationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var welcomeStackView: UIStackView!
    
    private let viewModel = AuthorisationViewModel()
    private var welcomeStackOrigin: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setKeyboardNotification(
            #selector(keyboardWillAppear),
            for: UIResponder.keyboardWillShowNotification
        )
        setKeyboardNotification(
            #selector(keyboardWillDisappear),
            for: UIResponder.keyboardWillHideNotification
        )
    }
    
    override func viewDidLayoutSubviews() {
        welcomeStackOrigin = welcomeStackView.frame.origin.y
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: IBActions
    
    
    deinit {
        removeKeyboardNotification(UIResponder.keyboardWillShowNotification)
        removeKeyboardNotification(UIResponder.keyboardWillHideNotification)
    }
    
}

extension AuthorisationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
}

extension AuthorisationViewController {
    
    @objc private func keyboardWillAppear(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (
            userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        ).cgRectValue
        
        if welcomeStackView.frame.origin.y == welcomeStackOrigin {
            welcomeStackView.frame.origin.y = keyboardSize.height / 3
        }
    }
    
    @objc private func keyboardWillDisappear(_ notification: Notification) {
        if welcomeStackView.frame.origin.y != welcomeStackOrigin {
            welcomeStackView.frame.origin.y = welcomeStackOrigin
        }
    }
    
}
