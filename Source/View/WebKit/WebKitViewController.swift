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
public class WebKitViewController:BaseViewController {
    
    public init(urlRequest: NSURLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration() ) {
        super.init(nibName: nil, bundle: nil)
        self.configuration = configuration
        self.urlRequest    = urlRequest
    }
    public  convenience init(url: NSURL) {
        self.init(urlRequest: NSURLRequest(URL: url))
    }    
    public required init?(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest    = NSURLRequest(URL: NSURL(string: "")!)
        super.init(coder: aDecoder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    public override func prepareUI() {
        super.prepareUI()
        leftNavButtonClosure = {[unowned self]()->Void in
            if self.webKit.canGoBack {
                self.webKit.goBack()
            } else {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
        
        self.view.addSubview(webKit)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[webKit]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["webKit":webKit]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[webKit]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["webKit":webKit]))
        
        self.view.addSubview(progressView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[progressView]-0-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["progressView":progressView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[progressView(2)]", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["progressView":progressView]))
    }
    public override func prepareData() {
        super.prepareData()
        guard let request = self.urlRequest else {
            return
        }
        webKit.loadRequest(request)
        guard let title = self.titleString else {
            navigationTitle("详情")
            return
        }
        navigationTitle(title)
    }
    
    deinit {
        webKit.removeObserver(self, forKeyPath: titleKeyPath)
        webKit.removeObserver(self, forKeyPath: estimatedProgressKeyPath)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let theKeyPath = keyPath where object as? WKWebView == webKit else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
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
   
    public var titleString:String?
    
    public var configuration = WKWebViewConfiguration()
    public var urlRequest:NSURLRequest?
    
    public final lazy var webKit:WKWebView = {
        let webView = WKWebView(frame: CGRectZero, configuration: WKWebViewConfiguration())
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.addObserver(self, forKeyPath: titleKeyPath, options: .New, context: nil)
        webView.addObserver(self, forKeyPath: estimatedProgressKeyPath, options: .New, context: nil)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        if #available(iOS 9.0, *) {
            webView.allowsLinkPreview = true
        }
        return webView
    }()
    
    private final lazy var progressView:UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .Bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.backgroundColor = .clearColor()
        progressView.trackTintColor  = .clearColor()
        progressView.hidden = true
        return progressView
    }()
    
    private final lazy var closeButtonItem:UIBarButtonItem = {
        let item = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: #selector(closeButtonAction(_:)))
        item.tintColor = UIColor.whiteColor()
        item.width = 6
        return item
    }()
}

extension WebKitViewController:WKNavigationDelegate{
    public func webView(webView: WKWebView, didCommitNavigation navigation: WKNavigation!){
        updateNavigationItems()
    }
}

extension WebKitViewController {
    private final func updateProgress() {
        let completed = webKit.estimatedProgress == 1.0
        progressView.hidden = completed
        progressView.setProgress(completed ? 0.0 : Float(webKit.estimatedProgress), animated: !completed)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = !completed
        if completed {
            webViewProgerssComplete()
        }
    }
    public func webViewProgerssComplete(){
        updateNavigationItems()
    }
    private func updateNavigationItems(){
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
    
    @objc private func closeButtonAction(sender:AnyObject){
        navigationController?.popViewControllerAnimated(true)
    }
}
