//
//  NetworkShadeView.swift
//  meiqu
//
//  Created by shenfh on 16/3/23.
//  Copyright © 2016年 com.meiqu.com. All rights reserved.
//

import UIKit

public enum NetworkShadeViewType:UInt{
    /// 数据正在加载
    case loading        = 0
    /// 数据加载失败
    case loadingFailure = 1
    /// 网络错误或没有网络
    case networkError   = 2
}


public protocol NetworkShadeProtocol:class {
    /**
     发生网络错误是刷新页面操作
     */
    func networkFailureRefresh()
}

/// 数据加载时的遮罩层页面
class NetworkShadeView:UIView {
    init(type:NetworkShadeViewType) {
        super.init(frame: CGRect.zero)
        prepareUI()
        showType = type
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if showType == .loading {
            if loadingView.superview != nil && loadingView.layer.sublayers == nil {
                let animation = MQActivityIndicatorAnimation(colors: [UIColor.color(0xff1d84),UIColor.color(0xFFA800),UIColor.color(0x909090)])
                animation?.setUpIn(loadingView.layer, size: CGSize(width: 30, height: 30), color: UIColor.color(0xff407c))
            }
        }
    }
    fileprivate func prepareUI(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addGestureRecognizer(gesture)
        self.isUserInteractionEnabled = true
        self.backgroundColor        = UIColor.clear
    }
    
    //MARK: public func
    /**
    显示遮罩层
    
    - parameter view: 父视图
    - parameter type: 遮罩层类型
    */
     func show(_ view:UIView,type:NetworkShadeViewType){
        if self.superview != nil {
            self.removeFromSuperview()
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[shadeView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["shadeView":self]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[shadeView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["shadeView":self]))
        showType = type
        
        if showType == .loading {
            showLoadingView()
        } else if showType == .loadingFailure {
            showLoadingFailureView()
        } else if showType == .networkError {
            showNetworkErrorView()
        }
    }
    /**
     移除遮罩层
     */
    func dismiss(){
        if !isShow {
            return
        }
        self.removeFromSuperview()
    }
    /**
     改变遮罩层样式
     
     - parameter type: 遮罩层类型
     */
    func changeView(_ type:NetworkShadeViewType) {
        if self.superview == nil {
            return
        }
        if showType == type {
            return
        }
        if type == .loading {
            showLoadingView()
        }else if type == .loadingFailure {
           showLoadingFailureView()
        } else if type == .networkError {
            showNetworkErrorView()
        }
        showType = type
    }
    
    
    fileprivate func showLoadingView(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(loadingView)       
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[loadingView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingView":loadingView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[loadingView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingView":loadingView]))
        self.layoutIfNeeded()
    }
    fileprivate func showLoadingFailureView(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(loadingFailureView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[loadingFailureView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingFailureView":loadingFailureView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[loadingFailureView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingFailureView":loadingFailureView]))
    }
    fileprivate func showNetworkErrorView(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(networkErrorView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[networkErrorView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["networkErrorView":networkErrorView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[networkErrorView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["networkErrorView":networkErrorView]))
    }
    
    @objc fileprivate func tapbackgroundAction(_ sender:AnyObject?){
        if showType == .networkError {
            if let delegate = self.delegate {
                delegate.networkFailureRefresh()
            }           
        }
    }
    
    //MARK: public var
    weak var delegate:NetworkShadeProtocol?
    /// is shade view show
    var isShow:Bool {
        get{
            return self.superview != nil
        }
    }
    //MARK: private var
    fileprivate lazy var loadingView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var loadingFailureView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        imageView.image = UIImage(contentsOfFile: resoursePath("loading_failure"))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView(108)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(127)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -60))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment   = .center
        label.text            = "呃，出了点小状况哦~"
        label.font            = UIFont.systemFont(ofSize: 15)
        label.textColor       = UIColor.color(0x666666)
        view.addSubview(label)
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 15))
        
        return view
    }()
    fileprivate lazy var  networkErrorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clear
        imageView.image = UIImage(contentsOfFile: resoursePath("networkConnectionError"))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView(117)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[imageView(132)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: -80))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        label.textAlignment   = .center
        label.numberOfLines   = 0
        label.text            = "网络不给力哦~换个姿势试试看(*╯3╰)点此刷新"
        label.font            = UIFont.systemFont(ofSize: 15)
        label.textColor       = UIColor.color(0x666666)
        view.addSubview(label)

        view.addConstraint(NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: -15))
        return view
    }()
    
    fileprivate lazy var gesture:UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(NetworkShadeView.tapbackgroundAction(_:)))
        
        return gesture
    }()
    internal fileprivate(set) var showType:NetworkShadeViewType = .loading
}
