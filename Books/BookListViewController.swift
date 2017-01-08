//
//  ViewController.swift
//  Books
//
//  Created by Jonathon Day on 1/5/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import UIKit

class BookListViewController: UITableViewController {
    var bookStore: BookStore!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.title = "Books"
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsetsMake(statusBarHeight, 0, 0, 0)
        self.tableView.contentInset = insets
        self.tableView.scrollIndicatorInsets = insets
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        bookStore.fetchBooks {
            switch $0 {
            case .success:
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let x):
                print(x)
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "bookListCell", for: indexPath)
        cell.textLabel?.text = bookStore.books[indexPath.row].title
        cell.detailTextLabel?.text = "by \(bookStore.books[indexPath.row].author)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookStore.books.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showBook"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let book = bookStore.books[row]
                let detailViewController = segue.destination as! BookDetailViewController
                detailViewController.book = book
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

