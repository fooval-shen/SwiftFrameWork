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
    case Loading        = 0
    /// 数据加载失败
    case LoadingFailure = 1
    /// 网络错误或没有网络
    case NetworkError   = 2
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
        super.init(frame: CGRectZero)
        prepareUI()
        showType = type
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if showType == .Loading {
            if loadingView.superview != nil && loadingView.layer.sublayers == nil {
                let animation = MQActivityIndicatorAnimation(colors: [UIColor.color(0xff1d84),UIColor.color(0xFFA800),UIColor.color(0x909090)])
                animation.setUpAnimationInLayer(loadingView.layer, size: CGSize(width: 30, height: 30), color: UIColor.color(0xff407c))
            }
        }
    }
    private func prepareUI(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addGestureRecognizer(gesture)
        self.userInteractionEnabled = true
        self.backgroundColor        = UIColor.clearColor()
    }
    
    //MARK: public func
    /**
    显示遮罩层
    
    - parameter view: 父视图
    - parameter type: 遮罩层类型
    */
     func show(view:UIView,type:NetworkShadeViewType){
        if self.superview != nil {
            self.removeFromSuperview()
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[shadeView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["shadeView":self]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[shadeView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["shadeView":self]))
        showType = type
        
        if showType == .Loading {
            showLoadingView()
        } else if showType == .LoadingFailure {
            showLoadingFailureView()
        } else if showType == .NetworkError {
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
    func changeView(type:NetworkShadeViewType) {
        if self.superview == nil {
            return
        }
        if showType == type {
            return
        }
        if type == .Loading {
            showLoadingView()
        }else if type == .LoadingFailure {
           showLoadingFailureView()
        } else if type == .NetworkError {
            showNetworkErrorView()
        }
        showType = type
    }
    
    
    private func showLoadingView(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(loadingView)       
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[loadingView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingView":loadingView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[loadingView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingView":loadingView]))
        self.layoutIfNeeded()
    }
    private func showLoadingFailureView(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(loadingFailureView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[loadingFailureView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingFailureView":loadingFailureView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[loadingFailureView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["loadingFailureView":loadingFailureView]))
    }
    private func showNetworkErrorView(){
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.addSubview(networkErrorView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[networkErrorView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["networkErrorView":networkErrorView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[networkErrorView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["networkErrorView":networkErrorView]))
    }
    
    @objc private func tapbackgroundAction(sender:AnyObject?){
        if showType == .NetworkError {
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
    private lazy var loadingView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingFailureView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clearColor()
        imageView.image = UIImage(contentsOfFile: resoursePath("loading_failure"))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView(108)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[imageView(127)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: -60))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment   = .Center
        label.text            = "呃，出了点小状况哦~"
        label.font            = UIFont.systemFontOfSize(15)
        label.textColor       = UIColor.color(0x666666)
        view.addSubview(label)
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 15))
        
        return view
    }()
    private lazy var  networkErrorView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.clearColor()
        imageView.image = UIImage(contentsOfFile: resoursePath("networkConnectionError"))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[imageView(117)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[imageView(132)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView":imageView]))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: -80))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment   = .Center
        label.numberOfLines   = 0
        label.text            = "网络不给力哦~换个姿势试试看(*╯3╰)点此刷新"
        label.font            = UIFont.systemFontOfSize(15)
        label.textColor       = UIColor.color(0x666666)
        view.addSubview(label)

        view.addConstraint(NSLayoutConstraint(item: label, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 15))
        view.addConstraint(NSLayoutConstraint(item: label, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: -15))
        return view
    }()
    
    private lazy var gesture:UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(NetworkShadeView.tapbackgroundAction(_:)))
        
        return gesture
    }()
    internal private(set) var showType:NetworkShadeViewType = .Loading
}
