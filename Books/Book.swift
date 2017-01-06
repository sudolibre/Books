//
//  Post.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

internal struct Book: Equatable {
    internal let title: String
    internal let author: String
    internal let genre: String
    internal var checkedOut: Bool
    internal var user: User?
    
    static func ==(lhs: Book, rhs: Book) -> Bool {
        if let leftUser = lhs.user, let rightUser = rhs.user {
            return lhs.author == rhs.author || lhs.title == rhs.title || lhs.genre == rhs.genre || lhs.checkedOut == rhs.checkedOut || leftUser == rightUser
        } else {
        return lhs.author == rhs.author || lhs.title == rhs.title || lhs.genre == rhs.genre || lhs.checkedOut == rhs.checkedOut
        }
    }

    init(title: String, author: String, checkedOut: Bool, genre: String, user: User?) {
        self.title = title
        self.author = author
        self.checkedOut = checkedOut
        self.genre = genre
        self.user = user
        
    }
    
    init?(jsonDict: [String: Any]) {
        
        guard let checkedOut = jsonDict["checkedOut"] as? Bool,
            let author = jsonDict["author"] as? String,
            let title = jsonDict["title"] as? String,
            let genre = jsonDict["genre"] as?  String else {
                return nil
        }
        var userOptional: User? = nil
        if let userJSON = jsonDict["user"] as? [String: Any] {
            userOptional = User(userDict: userJSON)
        }
        
        self.init(title: title, author: author, checkedOut: checkedOut, genre: genre, user: userOptional)
    }
}

//title
//author??
//who has checked it out
//date due back
//if checked out is false date due back will be in JSON but will be null. if it is checked out there will be a due date
//who checked it out
//genre
