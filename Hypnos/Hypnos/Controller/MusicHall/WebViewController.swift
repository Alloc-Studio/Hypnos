//
//  WebViewController.swift
//  Hypnos
//
//  Created by Fay on 16/5/28.
//  Copyright © 2016年 DMT312. All rights reserved.
//

import UIKit
import SVProgressHUD

class WebViewController: UIViewController {

    var activity:ActivityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = activity?.title
        setWebView(activity!.url!)
    
    }

    func setWebView(url:String) {
        let web = UIWebView(frame: view.bounds)
        web.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        web.delegate = self
        view.addSubview(web)
    }

}


extension WebViewController:UIWebViewDelegate {
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.showWithStatus("页面正在加载中...")
        webView.stringByEvaluatingJavaScriptFromString("var removeObj = document.getElementById('db-global-nav');")
        webView.stringByEvaluatingJavaScriptFromString("removeObj.parentNode.removeChild(removeObj);")
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByClassName('nav-wrap')[0].style.display='none';")

    }

    func webViewDidFinishLoad(webView: UIWebView) {
        
        SVProgressHUD.dismiss()
    }



}