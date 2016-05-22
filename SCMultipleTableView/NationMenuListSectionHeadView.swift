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
        listNameLb?.frame = CGRectMake(0, 0, frame.width, frame.height)
        
        listNameLb?.textAlignment = .Left
        listNameLb?.font = UIFont.systemFontOfSize(13)
        listNameLb?.textColor = UIColor.blackColor()
        
        line = UIView()
        self.addSubview(line!)

        line?.frame = CGRectMake(5, frame.height - 1, frame.width - 10, 1)
        line?.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)

        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
