//
//  RegistrationViewModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

final class RegistrationViewModel {
    
    var isValid = false
    
    func textValidationMessage(for text: String, ofType validType: String.ValidTypes, _ errorMessage: Messages, _ validMessage: Messages) -> String {
        if text.isValid(typeOf: validType) {
            isValid = true
            
            return validMessage.rawValue
        }
        isValid = false
        
        return errorMessage.rawValue
    }
    
    func getDateFromPicker(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.string(from: date)
    }
    
    func getDateFromText(_ string: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        
        return formatter.date(from: string)
    }
    
    func numberFormat(with mask: String, _ phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for character in mask where index < numbers.endIndex {
            if character == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        return result
    }
    
    func ageValidation(_ date: Date) -> Bool {
        let calendar = NSCalendar.current
        let currentDate = Date()
        let age = calendar.dateComponents([.year], from: date, to: currentDate)
        let userAge = age.year
        
        guard let userAge = userAge else { return false}
        
        return userAge < 18 ? false : true
    }
    
}
