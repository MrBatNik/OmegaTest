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
    private let viewModel = RegistrationViewModel()
    
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
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let dateOfBirth = dateOfBirthTextField.text ?? ""
        let number = numberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let date = viewModel.getDateFromText(dateOfBirth) ?? Date()

        if firstName.isValid(typeOf: .name),
           lastName.isValid(typeOf: .name),
           viewModel.ageValidation(date),
           number.isValid(typeOf: .number),
           email.isValid(typeOf: .email),
           password.isValid(typeOf: .password) {
            viewModel.saveUserDate(
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                number: number,
                email: email,
                password: password
            )
            showAlert("Registration complete", with: "You successfully completed registration")
        } else {
            showAlert("Wrong input", with: "All fields should be filled in correctly.")
        }
    }
    
    deinit {
        removeKeyboardNotification(UIResponder.keyboardWillShowNotification)
        removeKeyboardNotification(UIResponder.keyboardWillHideNotification)
    }
    
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }

        switch textField {
            case firstNameTextField:
                let result = (text as NSString).replacingCharacters(in: range, with: string)
                firstNameTextField.text = result
                firstNameLabel.text = viewModel.textValidationMessage(for: result, ofType: .name, .invalidName, .validName)
                firstNameLabel.textColor = viewModel.isValid ? .systemGreen : .systemRed
            case lastNameTextField:
                let result = (text as NSString).replacingCharacters(in: range, with: string)
                lastNameTextField.text = result
                lastNameLabel.text = viewModel.textValidationMessage(for: result, ofType: .name, .invalidName, .validName)
                lastNameLabel.textColor = viewModel.isValid ? .systemGreen : .systemRed
            case dateOfBirthTextField:
                let result = (text as NSString).replacingCharacters(in: range, with: string)
                dateOfBirthTextField.text = viewModel.numberFormat(with: "XX.XX.XXXX", result)
                if result.isValid(typeOf: .date) {
                    guard let date = viewModel.getDateFromText(result) else { return false }
                    datePicker.date = date
                    if viewModel.ageValidation(date) {
                        dateOfBirthLabel.textColor = .systemGreen
                        dateOfBirthLabel.text = Messages.validDate.rawValue
                    } else {
                        dateOfBirthLabel.textColor = .systemRed
                        dateOfBirthLabel.text = Messages.invalidDate.rawValue
                    }
                }
            case numberTextField:
                let result = (text as NSString).replacingCharacters(in: range, with: string)
                numberTextField.text = viewModel.numberFormat(with: "+X (XXX) XXX XX XX", result)
                numberLabel.text = viewModel.textValidationMessage(for: result, ofType: .number, .invalidNumber, .validNumber)
                numberLabel.textColor = viewModel.isValid ? .systemGreen : .systemRed
            case emailTextField:
                let result = (text as NSString).replacingCharacters(in: range, with: string)
                emailTextField.text = result
                emailLabel.text = viewModel.textValidationMessage(for: result, ofType: .email, .invalidEmail, .validEmail)
                emailLabel.textColor = viewModel.isValid ? .systemGreen : .systemRed
            case passwordTextField:
                let result = (text as NSString).replacingCharacters(in: range, with: string)
                passwordTextField.text = result
                passwordLabel.text = viewModel.textValidationMessage(for: result, ofType: .password, .invalidPassword, .validPassword)
                passwordLabel.textColor = viewModel.isValid ? .systemGreen : .systemRed
            default:
                break
        }
        
        return false
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
    
    private func setupDateOfBirthTextField() {
        dateOfBirthTextField.inputView = datePicker
        dateOfBirthTextField.inputAccessoryView = setupToolBar()
    }
    
    @objc private func tapDoneButton() {
        dateOfBirthTextField.text = viewModel.getDateFromPicker(datePicker.date)
        if viewModel.ageValidation(datePicker.date) {
            dateOfBirthLabel.textColor = .systemGreen
            dateOfBirthLabel.text = Messages.validDate.rawValue
        } else {
            dateOfBirthLabel.textColor = .systemRed
            dateOfBirthLabel.text = Messages.invalidDate.rawValue
        }
        view.endEditing(true)
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
