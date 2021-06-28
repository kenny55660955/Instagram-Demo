//
//  StroageManager.swift
//  PracticeInstagram
//
//  Created by Kenny on 2021/6/26.
//

import Foundation
import FirebaseStorage

struct PhotoPost {
    enum UserPostType {
        case photo, type
    }
    
    let postType: UserPostType
}

class StorageManager {
    
    enum IGStorageManagerError: Error {
        case failToDownload
    }
    
    // MARK: - Properties
    static let shard = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    func uploadUserPhotoPost(model: PhotoPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL { (url, error) in
            guard let url = url,
                  error == nil else {
                completion(.failure(.failToDownload))
                return
                
            }
            completion(.success(url))
        }
    }
    
}
