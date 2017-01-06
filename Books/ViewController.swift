//
//  ViewController.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let bookStore = BookStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        //let globalPosts = try! PostStore.fetchGlobalPosts()
        bookStore.fetchGlobalPosts { result in
            print(result)
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

