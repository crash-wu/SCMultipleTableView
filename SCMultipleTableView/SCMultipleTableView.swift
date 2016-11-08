//
//  SCMultipleTableView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/13.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


/**
 *  @author crash         crash_wu@163.com   , 16-05-13 15:05:12
 *
 *  @brief  两级列表协议
 */
@objc public protocol SCMultipleTableDelegate : NSObjectProtocol{
    
    
    /**
     计算每个section中单元格数量
     
     :param: tableView 目标tableView
     :param: section 目标section
     
     :returns: section中单元格数量
     */
    func m_tableView(_ tableView:SCMultipleTableView, numberOfRowsInSection section : Int) ->Int
    
    
    /**
     单元格布局
     
     :param: tableView 目标tableView
     :param: indexPath 单元格索引
     
     :returns: 单元格
     */
    func m_tableView(_ tableView:SCMultipleTableView, cellForRowAtIndexPath indexPath: IndexPath) ->UITableViewCell?
    
    
    
    
    /**
     计算tableView section数量
     
     :param: tableView 目标tablieView
     
     :returns: section 数量
     */
    @objc optional func numberOfSectionsInSCMutlipleTableView(_ tableView:SCMultipleTableView) ->Int
    
    
    /**
     计算cell高度
     
     :param: tableView 目标tableView
     :param: indexPath cell 索引
     
     :returns: cell高度
     */
    @objc optional func m_tableView(_ tableView :SCMultipleTableView , heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat
    
    
    /**
     section headView 高度
     
     :param: tableView 目标tableView
     :param: section 待计算的section
     
     :returns: section headView 高度
     */
    @objc optional func m_tableView(_ tableView :SCMultipleTableView , heightForHeaderInSection section :Int) ->CGFloat
    
    
    
    /**
     section footView 高度
     
     :param: tableView 目标tableView
     :param: section   待计算的section
     
     :returns: section headView 高度
     */
    @objc optional func m_tableView(_ tableView :SCMultipleTableView , heightForFootInSection section :Int) ->CGFloat
    
    
    
    /**
     section headView 样式
     
     :param: tableView 目标tableView
     :param: section
     
     :returns: section headView 样式
     */
    @objc optional func m_tableView(_ tableView:SCMultipleTableView,viewForHeaderInSection section :Int) ->UIView?
    
    
    /**
     展开section 中的row 单元格
     
     :param: tableView
     :param: section 需要展开的section
     */
    @objc optional func m_tableView(_ tableView:SCMultipleTableView , willOpenSubRowFromSection section :Int) ->Void
    
    
    /**
     收起section 中的row 单元格
     
     :param: tableView
     :param: section 需要收起的section
     
     :returns:
     */
    @objc optional func m_tableView(_ tableView:SCMultipleTableView ,willCloseSubRowFromSection section :Int) ->Void
    
    
    /**
     选中单元格
     
     :param: tableView
     :param: indexPath 单元格索引
     
     :returns:
     */
    @objc optional func m_tableView(_ tableView:SCMultipleTableView ,didSelectRowAtIndexPath indexPath :IndexPath) ->Void
    
    @objc optional func  m_scrollViewDidScroll(_ scrollView: UIScrollView)
    
    
    @objc optional  func m_scrollViewDidZoom(_ scrollView: UIScrollView) // any zoom scale changes
    
    // called on start of dragging (may require some time and or distance to move)
    @objc optional  func m_scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest

    @objc optional  func m_scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    @objc optional  func m_scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    

    @objc optional  func m_scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) // called on finger up as we are moving

    @objc optional  func m_scrollViewDidEndDecelerating(_ scrollView: UIScrollView) // called when scroll view grinds to a halt
    

    @objc optional  func m_scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    @objc optional  func viewForZoomingInScrollView(_ scrollView: UIScrollView) -> UIView? // return a view that will be scaled. if delegate returns nil, nothing happens
    
    @objc optional  func m_scrollViewWillBeginZooming(_ scrollView: UIScrollView, withView view: UIView?) // called before the scroll view begins zooming its content
    

    @objc optional  func m_scrollViewDidEndZooming(_ scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) // scale between minimum and maximum. called after any 'bounce' animations
    

    @objc optional  func m_scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool // return a yes if you want to scroll to the top. if not defined, assumes YES

    @objc optional  func m_scrollViewDidScrollToTop(_ scrollView: UIScrollView) // called when scrolling animation finished. may be called immediately if already at top
    
}

open class SCMultipleTableView: UIView ,UITableViewDataSource,UITableViewDelegate {
    
   open var tableView :UITableView!
   open  var currentOpenedIndexPaths :Array<IndexPath>? = []//当前展开的所有cell的indexPath的数组
    
    weak open var multipleDelegate : SCMultipleTableDelegate? //多重表格代理
    
    public init(frame: CGRect ,style:UITableViewStyle) {
        super.init(frame: frame)
        tableView = UITableView(frame: frame, style: style)
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.addSubview(tableView!)
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    
    //=======================================//
    //          Mark :public methods          //
    //=======================================//
    /**
     根据标识符取出重用cell
     
     :param: identifier 标识符
     
     :returns: 可重用的cell，或者nil（如果没有可重用的）
     */
  open  func dequeueReusableCellWithIdentifier(_ identifier :String)->UITableViewCell?{
        
        return self.tableView.dequeueReusableCell(withIdentifier: identifier)
        
    }
    
    /**
     根据标识符 与cell索引取出可以重用的cell
     
     :param: identifier 标识符
     :param: indexPath  cell索引
     
     :returns:可重用的cell，或者nil（如果没有可重用的）
     */
   open func dequeueReusableCellWithIdentifier(_ identifier :String ,forIndexPath indexPath :IndexPath) ->UITableViewCell?{
        
        return self.tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    }
    
    
    
    /**
     根据标识符,取出可以重用的section headView or section footView
     
     :param: identifier 标识符
     
     :returns: 可重用的section headView or section footView
     */
   open func dequeueReusableHeaderFooterViewWithIdentifier(_ identifier:String)->UITableViewHeaderFooterView?{
        
        return self.tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
    }
    
    
    
    /**
     取消表格选中状态
     
     :param: indexPath 单元格索引
     :param: animate
     */
   open func deselectRowAtIndexPath(_ indexPath:IndexPath, animated animate:Bool)->Void{
        
        self.tableView.deselectRow(at: indexPath, animated: animate)
    }
    
    /**
     刷新数据
     */
   open func reload() ->Void{
        
        
        self.tableView!.reloadData()
    }
    
    /**
     刷新某一section的单元格
     
     :param: sections   需要重新刷新数据的section
     :param: animation 动画
     */
    open func reloadSections(_ sections: IndexSet, withRowAnimation animation: UITableViewRowAnimation){
        
        
        self.tableView.reloadSections(sections, with: animation)
        
    }
    
    //=======================================//
    //          Mark : private UITapGestureRecognizer             //
    //=======================================//
    
    /**
     为view添加一个tap手势，其行为为action
     
     :param: anction 要添加的手势含有的行为
     :param: view    需要添加手势的视图
     */
    fileprivate func addTapGestureRecognizerAction(_ anction:Selector,toView view:UIView) ->Void{
        
        let tapGR = UITapGestureRecognizer(target: self, action: anction)
        view.addGestureRecognizer(tapGR)
    }
    
    
    /**
     为view移除一个tap手势
     
     :param: view 要移除手势的view
     */
    fileprivate func removeTapGestureRecognizerInView(_ view:UIView) ->Void{
        
        let gestures = view.gestureRecognizers! as [UIGestureRecognizer]
        
        for  gr in gestures {
            
            if gr.view!.isEqual(view){
                
                view.removeGestureRecognizer(gr)
            }
        }
    }
    
    
    
    
    /**
     添加在header中的点击手势的方法
     
     :param: gesture 点击手势
     */
    @objc fileprivate func tableViewHeaderTouchUpInside(_ gesture : UITapGestureRecognizer) ->Void{
        
        let section = gesture.view?.tag
        
        openOrCloseRowWithSection(section!)
        
    }
    
    
    
    //.=======================================//
    //     Mark :open or close section row    //
    //=======================================//
    
    /**
     展开或者收起section中的row
     
     :param: section tableView 中的section
     */
    
    fileprivate func openOrCloseRowWithSection(_ section :Int) ->Void{
        
        var openedIndexPaths :Array<IndexPath>? = []//展开的表格
        var deleteIndexPaths :Array<IndexPath>? = []//收起的表格
        
        //判断当前是否有row被展开
        if self.currentOpenedIndexPaths?.count == 0 {
            
            //当前没有任何子列表被打开
            openedIndexPaths = self.indexPathsForOpenRowFromSection(section)
            
        }else{
            //当前有row被展开
            var found = false
            
            //遍历
            for ip in self.currentOpenedIndexPaths!{
                
                //关闭当前已经打开的子列表
                if ip.section == section{
                    found = true
                    deleteIndexPaths = self.indexPathsForCloseRowFromSection(section)
                    break
                }
            }
            
            //展开新的section
            if !found {
                
                openedIndexPaths = self.indexPathsForOpenRowFromSection(section)
                
            }
            
        }
        
        self.tableView.beginUpdates()
        
        if openedIndexPaths?.count > 0 {
            self.tableView.insertRows(at: openedIndexPaths!, with: .automatic)
        }
        
        
        if deleteIndexPaths?.count > 0 {
            
            self.tableView.deleteRows(at: deleteIndexPaths!, with: .automatic)
        }
        self.tableView.endUpdates()
        
        let range = NSRange(location: section, length: 1)
        let indexSet = IndexSet(integersIn: range.toRange() ?? 0..<0)
        self.tableView.reloadSections(indexSet, with: .automatic)
    }
    
    /**
     展开一个section 中的row
     
     :param: section 待展开的row所在的section
     
     :return:  该section内所有indexPath信息
     */
    fileprivate func indexPathsForOpenRowFromSection(_ section:Int) ->Array<IndexPath>?{
        
        var indexPaths :Array<IndexPath>? = []
        
        let rowCount = get_numberOfRowsInSection(section)
        
        //调用代理,判断代理是否实现展开section row 的方法
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:willOpenSubRowFromSection:))) {
            //如果实现该方法，
            self.multipleDelegate?.m_tableView!(self, willOpenSubRowFromSection: section)
        }
        
        //打开了第section个子列表
        self.currentOpenedIndexPaths?.append(IndexPath(row: -1, section: section))
        
        //往当前section中添加row
        
        for i in 0 ..< rowCount {
            
            indexPaths?.append(IndexPath(row: i , section: section))
            
        }
        
        return indexPaths
    }
    
    
    
    /**
     收起已经展开的section
     
     :param: section 需要收起的section
     
     :returns: 该section内所有indexPath信息
     */
    fileprivate func indexPathsForCloseRowFromSection(_ section:Int) -> Array<IndexPath>?{
        
        var indexPathS :Array<IndexPath>? = []
        
        let rowCount = self.get_numberOfRowsInSection(section)
        
        //判断代理是否实现收起section中的行
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:willCloseSubRowFromSection:))) {
            
            self.multipleDelegate?.m_tableView!(self, willCloseSubRowFromSection: section)
        }
        
        //遍历数组，删除元素
        for (index ,value ) in (self.currentOpenedIndexPaths?.enumerated())!{
            
            if value.section == section{
                
                self.currentOpenedIndexPaths?.remove(at: index)
                break
            }
            
        }
        
        
        //关闭第section个子列表
        for i in 0..<rowCount{
            
            indexPathS?.append(IndexPath(row: i , section: section))
        }
        
        
        return indexPathS
        
    }
    
    
    //.=======================================//
    //          Mark :  UITableViewDateSource        //
    //=======================================//
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //查找没有打开row 的section
        var found = false
        
        for ip in self.currentOpenedIndexPaths!{
            if section == ip.section {
                
                found = true
                break
            }
            
        }
        //判断row 是否已经打开
        if found {
            //如果打开了，则需要计算该section下有多少row
            
            return get_numberOfRowsInSection(section)
            
        }else{
            //如果没有打开，则返回0
            return 0
        }
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height :CGFloat = 0
        if self.multipleDelegate != nil &&  self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:heightForRowAtIndexPath:))){
            
            height = (self.multipleDelegate?.m_tableView!(self, heightForRowAtIndexPath: indexPath))!
        }
        
        return height
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return get_cellForRowAtIndexPath(indexPath)
    }
    
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return get_numberOfSection()
    }
    
    //.=======================================//
    //          Mark :UITableDelegate          //
    //=======================================//
    
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        get_didSelectRowAtIndexPath(indexPath)
    }
    
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
        var height :CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.numberOfSectionsInSCMutlipleTableView(_:))){
            
            height = get_heightForHeaderInSection(section)
        }
        
        return height
    }
    
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        var height :CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.numberOfSectionsInSCMutlipleTableView(_:))){
            
            height = get_heightForFootInSection(section)
        }
        
        return height
        
    }
    
    
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = get_viewForHeaderInSection(section)
        
        if headView != nil{
            
            let height  = self.tableView(tableView, heightForHeaderInSection: section)
            headView?.frame = CGRect(x: 0, y: 0, width: self.tableView!.frame.size.width, height: height)
            headView?.tag = section
        }
        
        
        //给section headView 添加点击事件
        addTapGestureRecognizerAction(#selector(SCMultipleTableView.tableViewHeaderTouchUpInside(_:)), toView: headView!)
        
        return headView
        
    }
    
    //.=======================================//
    //          Mark :  private func         //
    //=======================================//
    
    
    /**
     获取每个section中的row数目
     
     :param: section 表格中的section
     
     :returns: section中的row数目
     */
    fileprivate func get_numberOfRowsInSection(_ section:Int) ->Int{
        
      //  var row = self.multipleDelegate?.m_tableView(self, numberOfRowsInSection: section) ?? 0
        
        var row : Int = 0

        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:numberOfRowsInSection:))) {
            
            row = self.multipleDelegate!.m_tableView(self, numberOfRowsInSection: section)
        }
        
        return row
        
    }
    
    
    /**
     获取表格中的section数目
     
     :returns: 获取表格中的section数目
     */
    fileprivate func get_numberOfSection() ->Int{
        
        var number = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.numberOfSectionsInSCMutlipleTableView(_:))) {
            
            number = (self.multipleDelegate?.numberOfSectionsInSCMutlipleTableView!(self))!
        }
        
        return number
    }
    
    
    /**
     获取tableView 中的单元格
     
     :param: indexPath 表格索引
     
     :returns: 返回tableView中的单元格
     */
    fileprivate func get_cellForRowAtIndexPath(_ indexPath:IndexPath) ->UITableViewCell{
        
        var cell :UITableViewCell?
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:cellForRowAtIndexPath:))) {
            
            cell = self.multipleDelegate?.m_tableView(self, cellForRowAtIndexPath: indexPath)
        }
        
        return cell!
    }
    
    
    
    /**
     获取点中的单元格
     
     :param: indexPath 单元格索引
     */
    fileprivate func get_didSelectRowAtIndexPath(_ indexPath:IndexPath) ->Void{
        
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:didSelectRowAtIndexPath:))) {
            
            self.multipleDelegate?.m_tableView!(self, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    
    /**
     获取tableView section头部高度
     
     :param: section section索引
     
     :returns: 返回section头部高度
     */
    fileprivate func get_heightForHeaderInSection(_ section:Int) ->CGFloat{
        
        var height:CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:heightForHeaderInSection:))) {
            
            height = (self.multipleDelegate?.m_tableView!(self, heightForHeaderInSection: section))!
        }
        
        return height
        
    }
    
    
    
    /**
     获取tableView section尾部
     
     :param: section section索引
     
     :returns: 返回section尾部高度
     */
    fileprivate func get_heightForFootInSection(_ section:Int) ->CGFloat{
        
        var height:CGFloat = 0
        
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:heightForFootInSection:))) {
            
            height = (self.multipleDelegate?.m_tableView!(self, heightForFootInSection: section))!
        }
        
        return height
        
    }
    
    /**
     获取section headView
     
     :param: section tableView section索引
     
     :returns: tableView section headView
     */
    fileprivate func get_viewForHeaderInSection(_ section:Int) ->UIView?{
        
        var view :UIView?
        if self.multipleDelegate != nil && self.multipleDelegate!.responds(to: #selector(SCMultipleTableDelegate.m_tableView(_:viewForHeaderInSection:))) {
            
            view = self.multipleDelegate?.m_tableView!(self, viewForHeaderInSection: section)
        }
        
        return view
    }
    
    //MARK: UIScrollViewDelegate
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
            
        self.multipleDelegate?.m_scrollViewDidScroll?(scrollView)

    }
    
    open func scrollViewDidZoom(_ scrollView: UIScrollView) {

            
        self.multipleDelegate?.m_scrollViewDidZoom?(scrollView)
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

            
        self.multipleDelegate?.m_scrollViewWillBeginDragging?(scrollView)
    }
    
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
            
        self.multipleDelegate?.m_scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

            
        self.multipleDelegate?.m_scrollViewDidEndDecelerating?(scrollView)
    }
    
    
    open func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            
        self.multipleDelegate?.m_scrollViewDidEndScrollingAnimation?(scrollView)
    }
    
    open func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        var view :UIView?
            
        view = self.multipleDelegate?.viewForZoomingInScrollView?(scrollView)
        
        return view
    }
    
    open func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {

            
        self.multipleDelegate?.m_scrollViewWillBeginZooming?(scrollView, withView: view)
    }
    
    open func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {

            
        self.multipleDelegate?.m_scrollViewDidEndZooming?(scrollView, withView: view, atScale: scale)

    }
    
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {

        self.multipleDelegate?.m_scrollViewDidScrollToTop?(scrollView)
    }
    
    
    open func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {            
        return self.multipleDelegate?.m_scrollViewShouldScrollToTop?(scrollView) ?? false
    }
    
}
