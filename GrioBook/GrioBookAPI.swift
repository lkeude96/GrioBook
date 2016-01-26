//
//  GrioBookAPI.swift
//  GrioBook
//
//  Created by Eude Kinsley Lesperance on 1/26/16.
//  Copyright © 2016 Grio. All rights reserved.
//

import Foundation

import Alamofire

private typealias JSONObject = [String : AnyObject]


final class GrioBookAPI {
    static let sharedInstance = GrioBookAPI()
    
    private let apiUrl = "https://griobook-lkeude96.c9users.io/api/books/"
//    private var cachedBookList: [Book] = []
    
    func getBooks(completion: [Book] -> Void) {
        
//        if cachedBookList.count > 0 && !(Reachability.isConnectedToNetwork()) {
//            completion(cachedBookList)
//        }
        
        get() { JSON in
            if let result = JSON {
                let bookArray = result as! [JSONObject]
                var books: [Book] = []
                for book in bookArray {
                    books.append(Book(book: book))
                }
//                self.cachedBookList = books
                completion(books)
            }
        }
    }
    
    private func get(completion: AnyObject? -> Void) {
        request("GET", encoding: .JSON, parameters: nil, completion: completion)
    }
    
    private func post(parameters: [String: AnyObject]?, completion: AnyObject? -> Void) {
        request("POST", encoding: .JSON, parameters: parameters, completion: completion)
    }
    
    private func request(method: String, encoding: Alamofire.ParameterEncoding, parameters: [String : AnyObject]?, completion: AnyObject? -> Void) {
        let url = NSURL(string: apiUrl)!
        let urlRequest = NSMutableURLRequest(URL: url)
        urlRequest.HTTPMethod = method
        
        let request = encoding.encode(urlRequest, parameters: parameters).0
        
        print("Starting \(method): \(url)(\(parameters ?? [:]))")
        Alamofire.request(request).responseJSON { response in
            print("Finished \(method) \(url)")
            
            if(response.result.isSuccess) {
                let JSON = response.result.value
                completion(JSON)
            } else {
                print("Request error: \(response.result.error)")
                
                if let data = response.data {
                    print("Response data: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                }
                
                completion(nil)
            }
            
        }
        
    }
}