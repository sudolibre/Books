//
//  BookDetailViewController.swift
//  Books
//
//  Created by Jonathon Day on 1/6/17.
//  Copyright © 2017 dayj. All rights reserved.
//

import Foundation
import UIKit

class BookDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var checkedOutLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var checkOutButton: UIButton!
    @IBOutlet var usernameTextField: UITextField!
    
    @IBAction func checkOutButton(_ sender: UIButton) {
        if book.checkedOut {
            
        } else {
            checkOutBook(forUser: usernameTextField.text!)
        }
    }
    
    var book: Book!
    
    override func viewDidLoad() {
        checkOutButton.adjustsImageWhenDisabled = true
        checkOutButton.isEnabled = false
    }
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    func updateView() {
        titleLabel.text = book.title
        genreLabel.text = book.genre
        authorLabel.text = book.author
        navigationItem.title = book.title
        
        if book.checkedOut {
            checkedOutLabel.text = "Checked Out"
            checkOutButton.setTitle("Return", for: .normal)
        } else {
            checkedOutLabel.text = "Available"
            checkOutButton.setTitle("Check Out", for: .normal)
        }
    }
    
    func checkOutBook(forUser user: String) {
        BookStore.checkOutBook(book, forUser: user) {
            switch $0 {
            case .success:
                DispatchQueue.main.async {
                    self.book.checkedOut = true
                    self.updateView()
                }
            case .failure(let x):
                print(x)
            }
        }
    }
    
    func returnBook(forUser user: String) {
        BookStore.checkOutBook(book, forUser: user) {
            switch $0 {
            case .success:
                DispatchQueue.main.async {
                    self.book.checkedOut = false
                    self.updateView()
                }
            case .failure(let x):
                print(x)
            }
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if usernameTextField.text != nil {
            checkOutButton.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
