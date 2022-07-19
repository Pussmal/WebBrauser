//
//  ViewController.swift
//  WebBrauser
//
//  Created by Алексей Моторин on 19.07.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController {

  
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        progressView.isHidden = true
     
//        let reload = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
//        
     
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    private func loadWebSite(url: String?) {
        guard let url = url else { return }
        let urlString = "https://" + url
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
    
extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        progressView.isHidden = true
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        progressView.isHidden = false
        textField.endEditing(true)
        loadWebSite(url: adressTextField.text)
        return true
    }
}
