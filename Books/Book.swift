//
//  Post.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

internal class Book: Equatable {
    internal let id: Int
    internal let title: String
    internal let author: String
    internal let genre: String
    internal var checkedOut: Bool
    internal var user: User?
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        if let leftUser = lhs.user, let rightUser = rhs.user {
            return lhs.author == rhs.author || lhs.title == rhs.title || lhs.genre == rhs.genre || lhs.checkedOut == rhs.checkedOut || leftUser == rightUser || lhs.id == rhs.id
        } else {
        return lhs.author == rhs.author || lhs.title == rhs.title || lhs.genre == rhs.genre || lhs.checkedOut == rhs.checkedOut || lhs.id == rhs.id
        }
    }

    init(title: String, author: String, checkedOut: Bool, genre: String, user: User?, id: Int) {
        self.title = title
        self.author = author
        self.checkedOut = checkedOut
        self.genre = genre
        self.user = user
        self.id = id
        
    }
    
    convenience init?(jsonDict: [String: Any]) {
        
        guard let checkedOut = jsonDict["checkedOut"] as? Bool,
            let author = jsonDict["author"] as? String,
            let title = jsonDict["title"] as? String,
            let id = jsonDict["id"] as? Int,
            let genre = jsonDict["genre"] as?  String else {
                return nil
        }
        var userOptional: User? = nil
        if let userJSON = jsonDict["user"] as? [String: Any] {
            userOptional = User(userDict: userJSON)
        }
        
        self.init(title: title, author: author, checkedOut: checkedOut, genre: genre, user: userOptional, id: id)
    }
}
