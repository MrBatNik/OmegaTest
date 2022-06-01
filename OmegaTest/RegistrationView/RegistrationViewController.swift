//
//  RegistrationViewController.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var registrationScrollView: UIScrollView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDateOfBirthTextField()
        setKeyboardNotification(
            #selector(keyboardWillAppear),
            for: UIResponder.keyboardWillShowNotification
        )
        setKeyboardNotification(
            #selector(keyboardWillDisappear),
            for: UIResponder.keyboardWillHideNotification
        )
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func tapRegistrationButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        dateOfBirthTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
}

extension RegistrationViewController {
    
    private func setupToolBar() -> UIView {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.backgroundColor = .systemGray
        toolBar.sizeToFit()
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        return toolBar
    }
    
    @objc private func tapDoneButton() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    private func setupDateOfBirthTextField() {
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.inputAccessoryView = setupToolBar()
    }
    
    private func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
    }
    
    @objc private func keyboardWillAppear(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = (
            userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        ).cgRectValue
        
        registrationScrollView.contentInset.bottom = keyboardSize.height
    }
    
    @objc private func keyboardWillDisappear(_ notification: Notification) {
        registrationScrollView.contentInset.bottom = .zero
    }
    
}
