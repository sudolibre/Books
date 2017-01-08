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
        var result = [Book]()
        let expected: [Book] = [Book(title: "Harry Potter", author: "JK Rowling", checkedOut: false, genre: "Fantasy",user: nil, id: 0), Book(title: "Moby Dick", author: "Herman Melville", checkedOut: false, genre: "Fiction", user: nil, id: 1)]
        BookStore.fetchBooks() {
            switch $0 {
            case .success(let x):
                result = x
            default:
                fatalError()
            }
            XCTAssertTrue(result == expected)
        }
        
    }
    
    func testCheckOutBook() {
        let exp = expectation(description: "book was returned")
        
        let book = Book(title: "Harry Potter", author: "JK Rowling", checkedOut: false, genre: "Fantasy",user: nil, id: 0)
        
        BookStore.checkOutBook(book, forUser: "John Doe") {
            if $0 == PostsResult.success([]) {
                exp.fulfill()
            }
            print($0)
        }

        waitForExpectations(timeout: 30.0)
    }
    
    func testReturnBook() {
        let exp = expectation(description: "book was returned")
        
        let book = Book(title: "Harry Potter", author: "JK Rowling", checkedOut: false, genre: "Fantasy",user: nil, id: 0)
        
        BookStore.returnBook(book, forUser: "John Doe") {
            if $0 == PostsResult.success([]) {
                exp.fulfill()
            }
            print($0)
        }
        
        waitForExpectations(timeout: 30.0)
    }
    
//    func testCheckOutBook() {
//        
//    }
    
}
