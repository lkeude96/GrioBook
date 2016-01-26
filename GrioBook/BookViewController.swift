//
//  BookViewController.swift
//  GrioBook
//
//  Created by Eude Kinsley Lesperance on 1/25/16.
//  Copyright © 2016 Grio. All rights reserved.
//

import UIKit
import Mattress

class BookViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var bookWebView: UIWebView!
    
    var bookUrl: String!
    var bookTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .navigationItem.title = bookTitle
        
        bookWebView.delegate = self
        
        let url = NSURL(string: bookUrl)!
        let request = NSURLRequest(URL: url)
        
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            cachePage(bookUrl)
            self.bookWebView.loadRequest(request)

        } else {
            print("Internet connection FAILED")
            let alert = UIAlertController(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                print(action)
            }
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func cachePage(urlToCache: String) {
        print("Caching Page ...")
        
        if let cache = NSURLCache.sharedURLCache() as? Mattress.URLCache, urlToCache = NSURL(string: urlToCache) {
            cache.diskCacheURL(urlToCache,
                loadedHandler: { (bookWebView) -> (Bool) in
                    let state = bookWebView.stringByEvaluatingJavaScriptFromString("document.readyState")
                    
                    if state == "complete" {
                        return true
                    }
                    
                    return false
                }, completeHandler: { () -> Void in
                    print("Finished Caching.")
                }, failureHandler:  { (error) -> Void in
                    print("Error Caching: \(error)")
                    
                    
            })
        }
    }
}
