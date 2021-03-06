//
//  StorageManager.swift
//  test_instagram
//
//  Created by 권성철 on 2021/02/21.
//


import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStroageManagerError: Error {
        case failedToDownload
    }
    
    public func uploadUsersPost(model: UserPost, complition: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStroageManagerError>) -> Void){
        bucket.child(reference).downloadURL(completion: {url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
