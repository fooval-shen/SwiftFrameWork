# SwiftFrameWork
Swift 开发的基础库封装

# Requirements
 * Swift 3.0+
 * Xcode 8+
# HeaderRefreshProtocol
 下拉刷新协议
```
public protocol HeaderRefreshProtocol:class {
    var refreshScrollView:UIScrollView {get}
    func refreshAction()
}

extension HeaderRefreshProtocol {    
    /// 添加下来刷新功能
    public func addRefreshView(){
        if let _ = refreshScrollView.header as? RefreshView {
            return
        }
        refreshScrollView.header = RefreshView.refresh({[weak self] () -> Void in
            guard let strongSelf = self else {return}
            strongSelf.refreshAction()
        })
    }
    /// 开始下拉刷新
    public func beginRefresh(){
        guard let refreshView = refreshScrollView.header as?RefreshView else {return}
        if !refreshView.isRefreshing() {
            refreshView.beginRefreshing()
        }
        
    }
    /// 结束下拉刷新
    public func endRefresh(){
        guard let refreshView = refreshScrollView.header as? RefreshView else {return}
        if refreshView.isRefreshing() {
            refreshView.endRefreshing()
        }
    }    
}
```
 * 使用方式

 ```
extension PageContentViewController:HeaderRefreshProtocol {
    public var refreshScrollView:UIScrollView {
        return self.collectionView
    }   
    public func refreshAction() {
       loadData(0)
    }
}
public override func viewDidLoad() {
    super.viewDidLoad()      
    addRefreshView()        
}

 ```
## ShadeViewProtocol 遮照层
```
public enum NetworkShadeViewType:UInt{
    /// 数据正在加载
    case Loading        = 0
    /// 数据加载失败
    case LoadingFailure = 1
    /// 网络错误或没有网络
    case NetworkError   = 2
}
```
* 使用方式
```
  extension PageContentViewController:ShadeViewProtocol {
    public var containerView:UIView {
        return self.view
    }
    public func networkFailureRefresh() {
        
    }
  }
  extension PageContentViewController{
    private func loadData(offset:Int){
        let parm:JSON = ["size":defatltNetworkSize,
                         "offset":offset,
                         "iGameId":self.categoryID]
        networkGet(URLRoute.news.path, param: parm) {[weak self] (status, message, jsonValue) in
            guard let strongSelf = self else {
                return
            }
            guard let jsonValue = jsonValue  else {
                runInMainThread({ 
                    strongSelf.endRefresh()
                })
                return
            }
            
            func changeModel(object:AnyObject)->ContentModel {
                let model = ContentModel()
                model.parse(object)
                return model
            }
            if status == .Success {
                if offset == 0 {
                    strongSelf.dataSource.removeAll()
                }
                let array = jsonValue.arrayValue.map({changeModel($0.rawValue)})
                strongSelf.dataSource.addFromArray(array)
                if array.count < defatltNetworkSize {
                    strongSelf.canLoadMore = false
                } else {
                    strongSelf.canLoadMore = true
                }
            }
            runInMainThread({
                strongSelf.endRefresh()
                if offset == 0 {
                    if strongSelf.dataSource.count > 0 {
                       strongSelf.dismissShadeView()
                    } else {
                        strongSelf.showShadeView(.LoadingFailure)
                    }                    
                }
                strongSelf.collectionView.reloadData()
            })
        }
    }
 }
  
```

## HUDProtocol 提示框协议

```
public protocol HUDProtocol:class {
    var containerView :UIView {get}
}

extension HUDProtocol {
    public func showMessage(message:String,delay:NSTimeInterval = 2){
        hudViewModel       = .Text
        hudView.label.text = message
        showHudView(delay)
    }
    
    public func showMessage(message:String,customView:UIView,delay:NSTimeInterval = 2){
        hudViewModel       = .CustomView
        hudView.label.text = message
        hudView.customView = customView
        showHudView(delay)
    }
    
    private func showHudView(delay:NSTimeInterval){
        containerView.addSubview(hudView)
        hudView.showAnimated(true)
        hudView.hideAnimated(true, afterDelay: delay)
    }
    private var hudView:MBProgressHUD {
        get{
            if let view = objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD {
                return view
            }
            let view = MBProgressHUD(view: self.containerView)
            view.removeFromSuperViewOnHide = true
            view.square          = true
            MBProgressHUD.appearance().contentColor = UIColor.whiteColor()
            view.bezelView.color = UIColor.blackColor()
            objc_setAssociatedObject(self, &HUDKey, view, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
    }
    private var hudViewModel:MBProgressHUDMode {
        set {
            if hudView.mode != newValue {
                hudView.mode = newValue
            }
        }
        get {
            return hudView.mode
        }
    }
}
```


## CommonHeader 常用的一些函数

```
/**
 在主线程执行
 
 */
public func runInMainThread(block:dispatch_block_t!){
    if( NSThread.currentThread().isMainThread){
        block()
    }else{
        dispatch_async(dispatch_get_main_queue(),block)
    }
}
/**
 后台线程执行
 
 */
public func runInBackgroundThread(block:dispatch_block_t!){
    dispatch_async(backgroundQueue, block);
}


///获取设备唯一标识
public func deviceIdentifier()->String {
    if let uid =  SSKeychain.passwordForService(ServiceName, account: ServiceAccount) {
        return uid
    }
    let newUUID = (UIDevice.currentDevice().identifierForVendor?.UUIDString ??  NSUUID().UUIDString).lowercaseString
    SSKeychain.setPassword(newUUID, forService: ServiceName, account: ServiceAccount)
    return newUUID
}
public func uuidString()->String {
    return NSUUID().UUIDString.lowercaseString
}


```
