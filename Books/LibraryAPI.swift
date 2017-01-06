//
//  AppNetAPI.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation

internal struct LibraryAPI {
    internal enum Error: Swift.Error {
        case invalidJSONData
    }
    
    internal static let url : URL = URL(string: "https://tiy-todo-angular.herokuapp.com/get-all-books.json")!
    
}
