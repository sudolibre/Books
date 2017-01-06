//
//  PostStore.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

enum PostsResult {
    case success([Book])
    case failure(BookStore.Error)
}

internal final class BookStore {
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        case system(Swift.Error)
    }
    
    fileprivate let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    internal func fetchGlobalPosts(completion: @escaping (PostsResult) -> ()) {
        let task = session.dataTask(with: LibraryAPI.url) { (optionalData, optionalResponse, optionalError) in
            if let data = optionalData, let dictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] {
                //completion(.success(something something))
                //OVERRIDING HERE WHILE WAITING ON API
                let filePath = URL.init(fileURLWithPath: "/Users/noj/Code/TIY/Books/Books/json.txt")
                let bookData = try? Data(contentsOf: filePath)
                if bookData != nil {
                    print("Saved Books found. Attempting to load.")
                    let jsonBooks = try? JSONSerialization.jsonObject(with: bookData!, options: []) as? [[String: Any]]
                    if let booksJSON = jsonBooks {
                        if let unwrappedBooksJSON = booksJSON {
                         let books = unwrappedBooksJSON.flatMap { Book.init(jsonDict:$0) }
                            return completion(.success(books))
                        }
                    } else {
                        print("No users found in save file")
                    }
                } else {
                    print("No existing users found. Starting an empty instance")
                }

            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion(.failure(error))
            } else {
            let error = optionalError!
            completion(.failure(.system(error)))
            }
            }
        task.resume()
        }

}
