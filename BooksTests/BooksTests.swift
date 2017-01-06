//
//  BooksTests.swift
//  BooksTests
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import XCTest
@testable import Books

class BooksTests: XCTestCase {
    
    func testInitBookWithJSON() {
        let filePath = URL.init(fileURLWithPath: "/Users/noj/Code/TIY/Books/Books/json.txt")
        let bookData = try! Data(contentsOf: filePath)
        let jsonBooks = try! JSONSerialization.jsonObject(with: bookData, options: []) as! [[String: Any]]
        let result = jsonBooks.flatMap { Book.init(jsonDict:$0) }
        let expected: [Book] = [Book(title: "iOS for Dummies", author: "TJ (who else?)", checkedOut: false, genre: "Technical", user: nil), Book(title: "Harry Potter and the something", author: "JK Rowling", checkedOut: false, genre: "Fantasy", user: nil), Book(title: "String Theory", author: "Foster Wallace", checkedOut: false, genre: "Biography", user: nil), Book(title: "100 years of solitude", author: "Gabriel Garcia Marquez", checkedOut: false, genre: "Fiction", user: User(id: 7000, lastName: "Developer", firstName: "Master", username: "dev@tiy.com"))]
        XCTAssertTrue(result == expected)
    }
    
}
