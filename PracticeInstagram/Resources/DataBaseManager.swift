//
//  DataBaseManager.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import Foundation
import FirebaseDatabase

class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    // MARK: - Method
    func canCreateNewUser(with email: String, userName: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        database.child(email.safeDataBaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                // successded
                completion(true)
            } else {
                // failed
                completion(false)
                return
            }
        }
    }
}


