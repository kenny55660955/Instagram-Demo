//
//  AuthManager.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import Foundation
import FirebaseAuth

class AuthManager {
    // MARK: - Properties
    static let shared = AuthManager()
    
    // MARK: - methods
    
    func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        // Check if userName is Available
        // Check if email is available
        // Create account
        // Insert account to database
        DataBaseManager.shared.canCreateNewUser(with: email, userName: userName) { result in
            if result {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    // KennyToDo: - 這段教學有問題待修
//                    guard error == nil, result != nil else {
//                        completion(false)
//                        return
//                    }
                    // Insert Data to database
                    DataBaseManager.shared.insertNewUser(with: email, username: userName) { result in
                        if result {
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                completion(false)
                return
            }
        }
        
    }
    
    func loginUser(userName: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)) {
        
        if let email = email {
            // email Login
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
//                guard result != nil, error == nil else {
//                    completion(false)
//                    return
//                }
                completion(true)
            }
             
        }
    }
     /// Attempt to log out firebase user
    func logout(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            print(error)
            completion(false)
            return
        }
    }
}
