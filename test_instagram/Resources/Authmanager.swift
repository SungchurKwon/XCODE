//
//  Authmanager.swift
//  test_instagram
//
//  Created by 권성철 on 2021/02/21.
//

import Foundation
import FirebaseAuth

public  class AuthManager{
    
    static let shared = AuthManager();
    
    public func registrerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        /*
        - Check if username is available
        - Check if email is available
        
        */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                /*
                 - Create account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard    error == nil, result != nil else{
                        // firebase auth couuld not create account
                        completion(false)
                        return
                    }
                    //Insert into database
                    DatabaseManager.shared.insertNewUsername(with: email, username: username) { inserted in
                        if inserted {
                            completion(true)
                            return
                        } else {
                            // Failed
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // either username or email does note exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if let email = email {
            // email log in
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username{
            // username log in
            print(username)
        }
    }
    
    /// Attempt to log out firebase user
    public  func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            completion(false)
            print(error)
            return
        }
    }
    
}
