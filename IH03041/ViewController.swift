//
//  ViewController.swift
//  IH03041
//
//  Created by 藤原吉司 on 2019/07/12.
//  Copyright © 2019 local.hal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UISearchBarDelegate, UITabBarDelegate {

    @IBOutlet weak var mainWebView: UIWebView!
    @IBOutlet weak var mainTabBar: UITabBar!
    @IBOutlet weak var searchKeywordBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainWebView.delegate = self
        searchKeywordBar.delegate = self

        // webViewをアプリっぽく見せる
        mainWebView.scalesPageToFit = true
        mainWebView.scrollView.bounces = false
        mainWebView.scrollView.showsHorizontalScrollIndicator = false
        mainWebView.scrollView.showsVerticalScrollIndicator = false
        
        let url = URL(string: "https://www.google.com")
        let urlRequest = URLRequest(url: url!)
        mainWebView.loadRequest(urlRequest)
        
        mainTabBar.delegate = self
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // webviewロード開始
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool { print("★★★shouldStartLoadWithrequest★★★")
        return true
    }
    
    // webview読み込み開始
    func webViewDidStartLoad(webview: UIWebView){
        print("★★★webViewDidStartLoad★★★")
    }
    
    // webviewエラー
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("★★★didFailLoadWithError★★★")
    }
    
    // webviewロード完了
    func webViewDidFinishLoad(_ webView: UIWebView){
        print("★★★webViewDidFinishLoad★★★")
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        var url = URL(string: "")
        switch item.tag {
        case 0:
            url = URL(string: "https://www.google.com")
        case 1:
            url = URL(string: "https://www.yahoo.com")
        case 2:
            url = URL(string: "https://www.amazon.com")
//        case 3:
//            url = URL(string: "https://www.rakuten.co.jp")
        default:
            url = URL(string: "https://www.google.com")
        }
        
        let urlRequest = URLRequest(url: url!)
        mainWebView.loadRequest(urlRequest)
    }
    
    // 検索する時
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar!) {
        let searchText = searchKeywordBar.text!
        var url = URL(string: "")

        // httpの場合
        if !searchText.hasPrefix("http://") &&
            !searchText.hasPrefix("https://") &&
            !searchText.hasPrefix("www.") {
            url = URL(string: searchKeywordBar.text!)

            let strvalue = searchKeywordBar.text!
            let urlstr = "https://www.google.com/search?q="+strvalue
            url = URL(string: urlstr)

        } else {
            url = URL(string: searchKeywordBar.text!)
        }
        
        let urlRequest = URLRequest(url: url!)
        mainWebView.loadRequest(urlRequest)
    }
    
    func urlEncode(string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters:
            NSCharacterSet.urlQueryAllowed)!
    }
}

