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

open class BaseTableViewController: BaseViewController {
    override open func viewDidLoad() {
        super.viewDidLoad();
        if xibTableView == nil {
            xibTableView = UITableView(frame: CGRect.zero, style: tableViewStyle)
            xibTableView?.backgroundColor = UIColor.color(0xeaeaea)
            xibTableView?.delegate        = self
            xibTableView?.dataSource      = self
            view.addSubview(self.xibTableView!)
            xibTableView?.showsVerticalScrollIndicator = false
            xibTableView!.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-\(tableViewInsets().left)-[tableView]-\(tableViewInsets().right)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["tableView" : xibTableView!]))
           self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(tableViewInsets().top)-[tableView]-\(tableViewInsets().bottom)-|", options: NSLayoutFormatOptions(rawValue:0), metrics: nil, views: ["tableView" : xibTableView!]))
        }
        self.xibTableView?.scrollsToTop = true
        
        if tableViewStyle == .grouped && self.tableView.tableFooterView == nil {
            self.tableView.tableFooterView = UIView()
        }
    }
    deinit {
        self.xibTableView?.delegate = nil
        self.xibTableView?.dataSource = nil
    }
    
    /**
    Auto load bottom data
    */
    open func autoLoadMore(){
        canLoadMore = false
    }
    
    open func tableViewInsets()->UIEdgeInsets{
        return UIEdgeInsets.zero
    }
    
    
    @IBOutlet fileprivate weak var xibTableView:UITableView?
    
    open var tableView:UITableView {
        return self.xibTableView!
    }
    open var tableViewStyle: UITableViewStyle = .grouped
    
    open  var dataSource: [AnyObject] = [AnyObject]()
    /// 是否可以上拉自动加载
    open var canLoadMore: Bool = false
    
}

// MARK: - UITableViewDataSource
extension BaseTableViewController:UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
}

// MARK: - UITableViewDelegate
extension BaseTableViewController:UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath){
        let dataCount = dataSource.count
        if(self.canLoadMore && (indexPath as NSIndexPath).row >= dataCount-5 && dataCount >= 5){
            autoLoadMore();
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude;
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude;
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil;
    }
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil;
    }

}



