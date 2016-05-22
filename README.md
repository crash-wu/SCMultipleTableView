# SCMultipleTableView
两级列表

#Usage

  var table : SCMultipleTableView?
  
  tableData =  [["section0-row0","section0-row1"],["section1-row0","section1-row1"],["section2-row0","section2-row1"]]
  
  # SCMultipleTableDelegate
  
      /**
     计算每个section中单元格数量
     
     :param: tableView 目标tableView
     :param: section 目标section
     
     :returns: section中单元格数量
     */
    func m_tableView(tableView:SCMultipleTableView, numberOfRowsInSection section : Int) ->Int
    
    
    /**
     单元格布局
     
     :param: tableView 目标tableView
     :param: indexPath 单元格索引
     
     :returns: 单元格
     */
    func m_tableView(tableView:SCMultipleTableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->UITableViewCell?
    
    

    
    /**
     计算tableView section数量
     
     :param: tableView 目标tablieView
     
     :returns: section 数量
     */
   optional func numberOfSectionsInSCMutlipleTableView(tableView:SCMultipleTableView) ->Int
    
    
    /**
     计算cell高度
     
     :param: tableView 目标tableView
     :param: indexPath cell 索引
     
     :returns: cell高度
     */
    optional func m_tableView(tableView :SCMultipleTableView , heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    
    
    /**
     section headView 高度
     
     :param: tableView 目标tableView
     :param: section 待计算的section
     
     :returns: section headView 高度
     */
    optional func m_tableView(tableView :SCMultipleTableView , heightForHeaderInSection section :Int) ->CGFloat
    
    
    
    /**
     section footView 高度
     
     :param: tableView 目标tableView
     :param: section   待计算的section
     
     :returns: section headView 高度
     */
    optional func m_tableView(tableView :SCMultipleTableView , heightForFootInSection section :Int) ->CGFloat
    
    
    
    /**
     section headView 样式
     
     :param: tableView 目标tableView
     :param: section
     
     :returns: section headView 样式
     */
    optional func m_tableView(tableView:SCMultipleTableView,viewForHeaderInSection section :Int) ->UIView?
    
    
    /**
     展开section 中的row 单元格
     
     :param: tableView
     :param: section 需要展开的section
     */
    optional func m_tableView(tableView:SCMultipleTableView , willOpenSubRowFromSection section :Int) ->Void
    
    
    /**
     收起section 中的row 单元格
     
     :param: tableView
     :param: section 需要收起的section
     
     :returns:
     */
    optional func m_tableView(tableView:SCMultipleTableView ,willCloseSubRowFromSection section :Int) ->Void
    
    
    /**
     选中单元格
     
     :param: tableView
     :param: indexPath 单元格索引
     
     :returns:
     */
    optional func m_tableView(tableView:SCMultipleTableView ,didSelectRowAtIndexPath indexPath :NSIndexPath) ->Void
  
  
