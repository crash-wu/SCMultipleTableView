//
//  NationMenuListSectionHeadView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/16.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationMenuListSectionHeadView: UIView {

    var expendImageView :UIImageView?
    var listNameLb :UILabel?
    var line :UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        listNameLb = UILabel()
        self.addSubview(listNameLb!)
        listNameLb?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        listNameLb?.textAlignment = .left
        listNameLb?.font = UIFont.systemFont(ofSize: 13)
        listNameLb?.textColor = UIColor.black
        
        line = UIView()
        self.addSubview(line!)

        line?.frame = CGRect(x: 5, y: frame.height - 1, width: frame.width - 10, height: 1)
        line?.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
