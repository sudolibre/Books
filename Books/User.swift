//
//  User.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

struct User: Equatable {
    let username: String
    let firstName: String
    let lastName: String
    let id: Int
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.username == rhs.username || lhs.firstName == rhs.firstName || lhs.lastName == rhs.lastName || lhs.id == rhs.id
    }
    
    init(id: Int, lastName: String, firstName: String, username: String) {
        self.id = id
        self.lastName = lastName
        self.firstName = firstName
        self.username = username
    }
    
    init?(userDict: [String: Any]) {
        guard let username = userDict["userName"] as? String,
        let firstName = userDict["firstName"] as? String,
        let lastName = userDict["lastName"] as? String,
        let id = userDict["id"] as? Int else {
                return nil
        }
        self.init(id: id, lastName: lastName, firstName: firstName, username: username)
    }
}
