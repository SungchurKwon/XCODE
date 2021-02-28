//
//  DatabaseManager.swift
//  test_instagram
//
//  Created by 권성철 on 2021/02/19.
//

import FirebaseDatabase

public  class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // MARK: - public
    
    /// Check if username email is available
    /// - Parameters
    ///  - email : string representing email
    ///  - username : string representing username
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    /// Insert new user data to databease
    /// - Parameters
    ///  - email : string representing email
    ///  - username : string representing username
    ///  - completion : Async callback for result if database entry succeded

    public func insertNewUsername(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        
        let key = email.safeDatabaseKey()
        database.child(key).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}
