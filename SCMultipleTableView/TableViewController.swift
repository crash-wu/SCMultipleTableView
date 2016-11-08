//
//  TableViewController.swift
//  SCMultipleTableView
//
//  Created by 吴小星 on 16/5/22.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class TableViewController: UIViewController,SCMultipleTableDelegate {

    var tableView : SCMultipleTableView?
    var data :Array<Array<String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView = SCMultipleTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .plain)
        tableView?.multipleDelegate = self
        
        tableView?.backgroundColor = UIColor.gray
        self.view.addSubview(tableView!)
        
        data = [["section0-row0","section0-row1"],["section1-row0","section1-row1"],["section2-row0","section2-row1"]]
        
 
        tableView?.reload()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //.=======================================//
    //          Mark :SCMultipleTableDelegate          //
    //=======================================//
    
    
    func numberOfSectionsInSCMutlipleTableView(_ tableView: SCMultipleTableView) -> Int {

        return data.count
    }
    
    
    func m_tableView(_ tableView: SCMultipleTableView, numberOfRowsInSection section: Int) -> Int {

        return data[section].count
    }
    
    
    func m_tableView(_ tableView: SCMultipleTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func m_tableView(_ tableView: SCMultipleTableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        return 30
    }
    
    
    func m_tableView(_ tableView: SCMultipleTableView, viewForHeaderInSection section: Int) -> UIView? {
        

        let  headView = NationMenuListSectionHeadView(frame:         CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        
        headView.listNameLb?.text = "section" + String(section)
        return headView
        
    }
    
    
    func m_tableView(_ tableView: SCMultipleTableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell? {
        
        
        let cellID = "cellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        if cell == nil{
            
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.backgroundColor = UIColor.blue
        cell?.textLabel?.text = data[indexPath.section][indexPath.row]
        
        return cell
    }
    



}
