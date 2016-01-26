//
//  BookListTableViewController.swift
//  GrioBook
//
//  Created by Eude Kinsley Lesperance on 1/25/16.
//  Copyright © 2016 Grio. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {
    
    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! BookListTableViewCell
        let book: Book = books[indexPath.row]
        
        cell.bookTitleLabel.text = book.title
        cell.bookAuthorLabel.text = book.author
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showBook", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showBook") {
            let bookView: BookViewController = segue.destinationViewController as! BookViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            let book: Book = books[indexPath.row]
            
            bookView.bookTitle = book.title
            bookView.bookUrl = book.getBookStringUrl()
            
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    func fetchBooks() {
        GrioBookAPI.sharedInstance.getBooks { books in
            // Sort collections by most recent first and reload the table.
            self.books = books
            self.tableView.reloadData()
        }
    }
}
