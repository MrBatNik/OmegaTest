//
//  AuthorisationViewModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 01.06.2022.
//

import Foundation

final class AuthorisationViewModel {
    
    func checkUserCredentials(_ email: String, password: String) -> Bool {
        guard let user = StorageManger.shared.users.first(where: { $0.email == email }) else { return false }
        
        if user.password == password {
            StorageManger.shared.saveActiveUser(user)
            return true
        }
        
        return false
    }
    
}
