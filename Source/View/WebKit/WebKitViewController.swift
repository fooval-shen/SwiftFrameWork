//
//  WebKitViewController.swift
//  meiqu
//
//  Created by shenfh on 16/8/25.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import UIKit
import WebKit

private let titleKeyPath = "title"
private let estimatedProgressKeyPath = "estimatedProgress"
open class WebKitViewController:BaseViewController {
    
    public init(urlRequest: URLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration() ) {
        super.init(nibName: nil, bundle: nil)
        self.configuration = configuration
        self.urlRequest    = urlRequest
    }
    public  convenience init(url: URL) {
        self.init(urlRequest: URLRequest(url: url))
    }    
    public required init?(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest    = URLRequest(url: URL(string: "")!)
        super.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    open override func prepareUI() {
        super.prepareUI()
        leftNavButtonClosure = {[unowned self]()->Void in
            if self.webKit.canGoBack {
                self.webKit.goBack()
            } else {
                 let _ = self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.view.addSubview(webKit)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[webKit]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["webKit":webKit]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[webKit]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["webKit":webKit]))
        
        self.view.addSubview(progressView)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[progressView]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["progressView":progressView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[progressView(2)]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["progressView":progressView]))
    }
    open override func prepareData() {
        super.prepareData()
        guard let request = self.urlRequest else {
            return
        }
        webKit.load(request)
        guard let title = self.titleString else {
            navigationTitle("详情")
            return
        }
        navigationTitle(title)
    }
    
    deinit {
        webKit.removeObserver(self, forKeyPath: titleKeyPath)
        webKit.removeObserver(self, forKeyPath: estimatedProgressKeyPath)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let theKeyPath = keyPath , object as? WKWebView == webKit else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if  theKeyPath == titleKeyPath && titleString == nil {
            if let title = webKit.title {
                 navigationTitle(title)
            }
        }

        if theKeyPath == estimatedProgressKeyPath {
            updateProgress()
        }
    }
   
    open var titleString:String?
    
    open var configuration = WKWebViewConfiguration()
    open var urlRequest:URLRequest?
    
    public final lazy var webKit:WKWebView = {
        let webView = WKWebView(frame: CGRect.zero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.addObserver(self, forKeyPath: titleKeyPath, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: estimatedProgressKeyPath, options: .new, context: nil)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        if #available(iOS 9.0, *) {
            webView.allowsLinkPreview = true
        }
        return webView
    }()
    
    fileprivate final lazy var progressView:UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = UIColor.clear
        progressView.trackTintColor  = UIColor.clear
        progressView.isHidden = true
        return progressView
    }()
    
    fileprivate final lazy var closeButtonItem:UIBarButtonItem = {
        let item = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeButtonAction(_:)))
        item.tintColor = UIColor.white
        item.width = 6
        return item
    }()
}

extension WebKitViewController:WKNavigationDelegate{
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
        updateNavigationItems()
    }
}

extension WebKitViewController {
    fileprivate final func updateProgress() {
        let completed = webKit.estimatedProgress == 1.0
        progressView.isHidden = completed
        progressView.setProgress(completed ? 0.0 : Float(webKit.estimatedProgress), animated: !completed)
        UIApplication.shared.isNetworkActivityIndicatorVisible = !completed
        if completed {
            webViewProgerssComplete()
        }
    }
    public func webViewProgerssComplete(){
        updateNavigationItems()
    }
    fileprivate func updateNavigationItems(){
        guard let items = self.navigationItem.leftBarButtonItems else {
            return
        }
        if self.webKit.canGoBack {
            if items.count < 3 {
               var newItems = [UIBarButtonItem]()
                newItems.addFromArray(items)
                newItems.append(closeButtonItem)
                self.navigationItem.setLeftBarButtonItems(newItems, animated: false)
            }
        } else {
            if items.count > 2 {
                var newItems = [UIBarButtonItem]()
                newItems.append(items[0])
                newItems.append(items[1])
                self.navigationItem.setLeftBarButtonItems(newItems, animated: false)
            }
        }
    }
    
    @objc fileprivate func closeButtonAction(_ sender:AnyObject){
         let _ = navigationController?.popViewController(animated: true)
    }
}
