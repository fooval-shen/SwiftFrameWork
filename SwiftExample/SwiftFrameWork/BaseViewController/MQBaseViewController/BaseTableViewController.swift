//
//  BaseTableViewController.swift
//  FHMeiLe
//
//  Created by shenfh on 15/12/2.
//  Copyright © 2015年 shenfh. All rights reserved.
//

import UIKit


extension UITableView{
    public func safeReload(){
        runInMainThread { () -> Void in
            self.reloadData()
        }
    }
}

public class BaseTableViewController: BaseViewController {
    override public func viewDidLoad() {
        super.viewDidLoad();
        if xibTableView == nil {
            xibTableView = UITableView(frame: CGRectZero, style: tableViewStyle)
            xibTableView?.backgroundColor = UIColor.color(0xeaeaea)
            xibTableView?.delegate        = self
            xibTableView?.dataSource      = self
            view.addSubview(self.xibTableView!)
            xibTableView?.showsVerticalScrollIndicator = false
            xibTableView!.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-\(tableViewInsets().left)-[tableView]-\(tableViewInsets().right)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["tableView" : xibTableView!]))
           self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(tableViewInsets().top)-[tableView]-\(tableViewInsets().bottom)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["tableView" : xibTableView!]))
        }
        self.xibTableView?.scrollsToTop = true
        
    }
    deinit {
        self.xibTableView?.delegate = nil
        self.xibTableView?.dataSource = nil
    }
    
    /**
    Auto load bottom data
    */
    public func autoLoadMore(){
        canLoadMore = false
    }
    
    public func tableViewInsets()->UIEdgeInsets{
        return UIEdgeInsetsZero
    }
    
    
    @IBOutlet private weak var xibTableView:UITableView?
    
    public var tableView:UITableView {
        return self.xibTableView!
    }
    public var tableViewStyle: UITableViewStyle = .Grouped
    
    public  var dataSource: [AnyObject] = [AnyObject]()
    /// 是否可以上拉自动加载
    public var canLoadMore: Bool = false
    
}

// MARK: - UITableViewDataSource
extension BaseTableViewController:UITableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
}

// MARK: - UITableViewDelegate
extension BaseTableViewController:UITableViewDelegate {
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        let dataCount = dataSource.count
        if(self.canLoadMore && indexPath.row >= dataCount-5 && dataCount >= 5){
            autoLoadMore();
        }
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1.0;
    }
    
    public func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0;
    }
    
    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil;
    }
    public func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }

}



