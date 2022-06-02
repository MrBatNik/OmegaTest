//
//  UserInformationViewModel.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 02.06.2022.
//

import Foundation

final class UserInformationViewModel {

    func retrieveUser() -> String {
        guard let activeUser = StorageManger.shared.activeUser else { return ""}
        
        return activeUser.fullUserData
    }
    
}
