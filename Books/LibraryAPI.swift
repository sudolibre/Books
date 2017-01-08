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

    private static let baseURL: String = "https://conor-tiy-library.herokuapp.com/"//"https://conor-tiy-library.herokuapp.com/"
    internal static let getBooksURL: URL = URL(string: baseURL + "getbooks.json")!
    internal static let checkOutBookURL: URL = URL(string: baseURL + "checkout.json")!
    internal static let returnBookURL: URL = URL(string: baseURL + "return.json")!
    
}
