//
//  UserModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

struct User: Codable {
    
    let firstName, lastName: String
    let dateOfBirth: String
    let number: String
    let email: String
    let password: String
    
    var fullUserData: String {
        """
        First name: \(firstName)
        Last name: \(lastName)
        Date of Birth: \(dateOfBirth)
        Number: \(number)
        Email address: \(email)
        """
    }
    
}
