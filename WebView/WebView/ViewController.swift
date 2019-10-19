//
//  ViewController.swift
//  WebView
//
//  Created by Olha Skulska on 2019. 10. 14..
//  Copyright © 2019. Olha Skulska. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBtn.isEnabled = false
        forwardBtn.isEnabled = false
        
        searchField.delegate = self
        webView.navigationDelegate = self
        
        let homePage = "https://music.youtube.com/"
        guard let url = URL(string: homePage) else {return}
        let request = URLRequest(url: url)
        
        searchField.text = homePage
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    @IBAction func goForward(_ sender: UIButton){
        if webView.canGoForward{
            webView.goForward()
        } else {
            forwardBtn.isEnabled = false
        }
    }
    
    @IBAction func goBack(_ sender: UIButton){
        if webView.canGoBack{
            webView.goBack()
        } else {
            backBtn.isEnabled = false
        }
    }

}

extension ViewController: WKNavigationDelegate, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let url = URL(string: textField.text!)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        searchField.text = webView.url?.absoluteString
        backBtn.isEnabled = webView.canGoBack
        forwardBtn.isEnabled = webView.canGoForward
    }
}
