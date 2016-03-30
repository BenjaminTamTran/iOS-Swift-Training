//
//  ViewController.swift
//  Task3
//
//  Created by tranquocsang on 3/29/16.
//  Copyright © 2016 tranquocsang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var textEntered: UITextField!
    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func btnPressed(sender: AnyObject) {
        print(textEntered.text)
        let URL = NSURL(string: textEntered.text!)
        let request = NSURLRequest(URL: URL!)
        webView.loadRequest(request)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let URL = NSURL(string: "http://www.apple.com")
        let request = NSURLRequest(URL: URL!)
        webView.loadRequest(request)
    }

    func webViewDidStartLoad(webView: UIWebView) {
        webView.hidden = true
        indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.hidden = false
        indicator.stopAnimating()
    }

}

