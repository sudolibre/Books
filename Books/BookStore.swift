//
//  PostStore.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

enum PostsResult {
    case success
    case failure(BookStore.Error)
    
    static func ==(lhs: PostsResult, rhs: PostsResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}

internal final class BookStore {
    var books = [Book]()
    
    enum Error: Swift.Error {
        case http(HTTPURLResponse)
        case system(Swift.Error)
        }
    
    fileprivate static let session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    internal static func checkOutBook(_ book: Book, forUser user: String, completion: @escaping (PostsResult) -> ()) {
        let data: [String: Any] = ["id": book.id, "user": user]
        print(data)
        let json = try! JSONSerialization.data(withJSONObject: data, options: [])
        postToEndpoint(endpoint: LibraryAPI.checkOutBookURL, withJSON: json) {  completion($0) }
    }
    
    internal static func returnBook(_ book: Book, forUser user: String, completion: @escaping (PostsResult) -> ()) {
        let data: [String: Any] = ["id": book.id, "user": user]
        let json = try! JSONSerialization.data(withJSONObject: data, options: [])
        postToEndpoint(endpoint: LibraryAPI.returnBookURL, withJSON: json) {  completion($0) }
    }
    
    private static func postToEndpoint(endpoint: URL, withJSON json: Data, completion: @escaping (PostsResult) -> ()) {
        var request = URLRequest(url: endpoint)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = json
        let task = session.dataTask(with: request) { (optionalData, optionalResponse, optionalError) in
            guard optionalResponse != nil else {
                print("\(optionalError!)")
                completion(.failure(.system(optionalError!)))
                return
            }
            print("successfully posted")
            completion(.success)
        }
        
        task.resume()
    }
    
    internal func fetchBooks(completion: ((PostsResult) -> ())? ) {
        
        let task = BookStore.session.dataTask(with: LibraryAPI.getBooksURL) { (optionalData, optionalResponse, optionalError) in
            if let data = optionalData {
                let optionalDataWithoutType = try? JSONSerialization.jsonObject(with: data, options: [])
                if let dataWithoutType = optionalDataWithoutType {
                    if let arrayOfDictionarys = dataWithoutType as? [[String: Any]] {
                        let newBooks = arrayOfDictionarys.flatMap { Book.init(jsonDict:$0) }
                        self.books = newBooks
                        completion?(.success)
                    } else {
                        print("JSON data could not be turned into an array of dictionaries")
                    }
                    
                } else {
                    print("Data present but could not be deserialized by Swift")
                }
            } else if let response = optionalResponse {
                let error = Error.http(response as! HTTPURLResponse)
                completion?(.failure(error))
            } else {
                let error = optionalError!
                completion?(.failure(.system(error)))
            }
        }
        task.resume()
    }
    
}
