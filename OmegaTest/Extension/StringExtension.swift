//
//  StringExtension.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

extension String {
    
    enum ValidTypes {
        case name, date, number, email, password
    }
    
    enum RegularExpression: String {
        case name = "[A-Za-z]{2,}"
        case date = "[0-9]{2}+\\.+[0-9]{2}+\\.+[0-9]{4}"
        case number = "\\+[0-9]+[ ]+\\(+[0-9]{3}+\\)+[ ]+[0-9]{3}+[ ]+[0-9]{2}+[ ]+[0-9]{2}"
        case email = "[A-Z0-9a-z-._]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,}"
        case password = "(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,}"
    }
    
    func isValid(typeOf validType: ValidTypes) -> Bool {
        let format = "SELF MATCHES %@"
        var regex = ""
        
        switch validType {
            case .name:
                regex = RegularExpression.name.rawValue
            case .date:
                regex = RegularExpression.date.rawValue
            case .number:
                regex = RegularExpression.number.rawValue
            case .email:
                regex = RegularExpression.email.rawValue
            case .password:
                regex = RegularExpression.password.rawValue
        }
        
        return NSPredicate(format: format, regex).evaluate(with: self)
    }
    
}
