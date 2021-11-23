//
//  WebKitViewController.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 04.10.2021.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    var webView: WKWebView!
    var urlString = String()
    var mainName = ""
    
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        let myURL = URL(string: urlString)!
        let request = URLRequest(url: myURL)
        webView.load(request)
    }
    
    func setupNavigationBar() {
        navigationItem.title = mainName
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "roboto-bold", size: 24)!, .foregroundColor: UIColor(named: "White") ?? UIColor.white]
        navigationController!.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor(named: "Coral")
        tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
}

extension WebKitViewController: WKUIDelegate {
    
}
