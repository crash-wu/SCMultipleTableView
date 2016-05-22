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
        
        tableView = SCMultipleTableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: .Plain)
        tableView?.delegate = self
        
        tableView?.backgroundColor = UIColor.grayColor()
        self.view.addSubview(tableView!)
        
        data = [["section0-row0","section0-row1"],["section1-row0","section1-row1"],["section2-row0","section2-row1"]]
        
 
        tableView?.reloadDate()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //.=======================================//
    //          Mark :SCMultipleTableDelegate          //
    //=======================================//
    
    
    func numberOfSectionsInSCMutlipleTableView(tableView: SCMultipleTableView) -> Int {

        return data.count
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, numberOfRowsInSection section: Int) -> Int {

        return data[section].count
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func m_tableView(tableView: SCMultipleTableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 30
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, viewForHeaderInSection section: Int) -> UIView? {
        

        let  headView = NationMenuListSectionHeadView(frame:         CGRectMake(0, 0, tableView.frame.width, 40))
        
        headView.listNameLb?.text = "section" + String(section)
        return headView
        
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        
        
        let cellID = "cellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID)
        
        if cell == nil{
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
        }
        
        cell?.backgroundColor = UIColor.blueColor()
        cell?.textLabel?.text = data[indexPath.section][indexPath.row]
        
        return cell
    }
    



}
