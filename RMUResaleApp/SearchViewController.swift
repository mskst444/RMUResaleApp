//
//  SearchViewController.swift
//  RMUResaleApp
//
//  Created by Mitchell Keller on 4/13/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    var results = SearchResult()
    let alert = UIAlertController(title: "Invalid Entry", message: "Must enter an ISBN or Title/Author", preferredStyle: .alert)
    let closeAction = UIAlertAction(title: "Close", style: .default)

    @IBOutlet weak var ISBNField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.ISBNField.delegate = self
        self.titleField.delegate = self
        self.authorField.delegate = self
        
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    //Method for dismissing keyboard with return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //This method will work for ALL text fields
    //dismiss keyboard when tapping elsewhere
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    //*************     SEARCH BUTTON FUNCTION     *************
    @IBAction func searchButton(_ sender: Any) {
        
        if(self.ISBNField.text != ""){
            mySearchRequest(self.ISBNField.text!)
            //segue to search results page
            performSegue(withIdentifier: "toSearchResultsSegue", sender: sender)
        }
        else if(self.authorField.text != "" && self.titleField.text != "") {
            mySearchRequest(self.titleField.text!, self.authorField.text!)
            //segue to search results page
            performSegue(withIdentifier: "toSearchResultsSegue", sender: sender)
        }
        else {
            alert.addAction(closeAction)
            present(alert, animated:true)
        }
        
        
        
    }
    
    //**********     SEARCH FUNCTION: ISBN     **********
    //Function to search for a book by ISBN number
    func mySearchRequest(_ isbn: String)
    {
        SearchResult.author = []
        SearchResult.isbn = []
        SearchResult.price = []
        SearchResult.sellerUsername = []
        SearchResult.title = []
        print(SearchResult.author)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let mySearchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        
        mySearchRequest.predicate = NSPredicate(format: "isbn = %@", isbn)
        
        // BEGIN ISBN SEARCH
        do{
            let bookResults = try managedContext.fetch(mySearchRequest)
            for book in bookResults
            {
                /* NOTE:
                 If there are results, this for loop will be entered and thus there is already a record with the attempted username
                 If there is no identical username already created, this loop will not even run once
                 */
                SearchResult.author.append("\(book.value(forKey: "author")!)")
                SearchResult.isbn.append("\(book.value(forKey: "isbn")!)")
                SearchResult.price.append(book.value(forKey: "price")! as! Float)
                SearchResult.sellerUsername.append("\(book.value(forKey: "sellerUsername")!)")
                SearchResult.title.append("\(book.value(forKey: "title")!)")
            }
            
        } catch let error{
            print(error)
            return
        }
        print(SearchResult.author)
        return
    }
    
    //**********     SEARCH FUNCTION: TITLE/AUTHOR     **********
    //Function to search for a book by Title and Author
    func mySearchRequest(_ title: String, _ author: String)
    {
        SearchResult.author = []
        SearchResult.isbn = []
        SearchResult.price = []
        SearchResult.sellerUsername = []
        SearchResult.title = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let mySearchRequest = NSFetchRequest<NSManagedObject>(entityName: "Books")
        
        mySearchRequest.predicate = NSPredicate(format: "title like %@", title)
        mySearchRequest.predicate = NSPredicate(format: "author like %@", author)
        
        // BEGIN SEARCH
        do{
            let bookResults = try managedContext.fetch(mySearchRequest)
            
            for book in bookResults
            {
                /* NOTE:
                 If there are results, this for loop will be entered and thus there is already a record with the attempted username
                 If there is no identical username already created, this loop will not even run once
                 */
                
                SearchResult.author.append("\(book.value(forKey: "author")!)")
                SearchResult.isbn.append("\(book.value(forKey: "isbn")!)")
                SearchResult.price.append(book.value(forKey: "price")! as! Float)
                SearchResult.sellerUsername.append("\(book.value(forKey: "sellerUsername")!)")
                SearchResult.title.append("\(book.value(forKey: "title")!)")
            }
            
        } catch let error{
            print(error)
            return
        }
        print(SearchResult.author)
        return
    }

    
}

struct SearchResult {
    static var author: [String] = []
    static var isbn: [String] = []
    static var price: [Float] = []
    static var sellerUsername: [String] = []
    static var title: [String] = []
    
}
