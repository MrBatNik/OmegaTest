//
//  StorageManger.swift
//  OmegaTest
//
//  Created by Nikita Batrakov on 30.05.2022.
//

import Foundation

enum UserKeys: String {
    case users, activeUser
}

final class StorageManger {
    
    static let shared = StorageManger()
    
    var users: [User] {
        get {
           retrieveUsers()
        }
        set {
            saveUsersData(newValue)
        }
    }
    var activeUser: User? {
        get {
            if let data = standardUserDefaults.value(forKey: activeUserKey) as? Data {
                return try! PropertyListDecoder().decode(User.self, from: data)
            }
            
            return nil
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                standardUserDefaults.set(data, forKey: activeUserKey)
            }
        }
    }
    
    private let standardUserDefaults = UserDefaults.standard
    private let userKey = UserKeys.users.rawValue
    private let activeUserKey = UserKeys.activeUser.rawValue
    
    private init() {}
    
    func saveUserData(_ user: User) {
        users.append(user)
    }
    
    func saveActiveUser(_ user: User) {
        activeUser = user
    }
    
    private func saveUsersData(_ user: [User]) {
        if let data = try? PropertyListEncoder().encode(user) {
            standardUserDefaults.set(data, forKey: userKey)
        }
    }
    
    private func retrieveUsers() -> [User] {
        if let data = standardUserDefaults.value(forKey: userKey) as? Data {
            return try! PropertyListDecoder().decode([User].self, from: data)
        }
        
        return [User]()
    }
    
}
