//
//  Book.swift
//  GrioBook
//
//  Created by Eude Kinsley Lesperance on 1/26/16.
//  Copyright © 2016 Grio. All rights reserved.
//

import Foundation

class Book {
    private let baseUrl = "http://eudelesperance.com/griobook/books/"
    
    var _id: String
    var title: String
    var author: String
    var fileName: String
    
    init(_id: String, title: String, author: String, fileName: String) {
        self._id = _id
        self.title = title
        self.author = author
        self.fileName = fileName
    }
    
    init(book: [String: AnyObject]) {
        self._id = book["_id"] as! String
        self.title = book["title"] as! String
        self.author = book["author"] as! String
        self.fileName = book["file_name"] as! String
    }
    
    func getBookStringUrl() -> String{
        return baseUrl + "/" + fileName
    }
}