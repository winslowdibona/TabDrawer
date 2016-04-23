//
//  TabBarItem.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import UIKit
import EasyPeasy

class TabBarItem: UIView {
    
    var tabDrawerItem : TabDrawerItem!
    var imageView : UIImageView!
    var titleLabel : UILabel!
    
    convenience init(tabDrawerItem : TabDrawerItem) {
        self.init(frame : CGRectZero)
        self.tabDrawerItem = tabDrawerItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
    }
    
    func setup() {
        makeLabel()
        makeImageView()
    }
    
    func makeImageView() {
        imageView = UIImageView(frame: CGRectZero)
        imageView.image = tabDrawerItem.icon
        addSubview(imageView)
        imageView <- [ Top(8), Width(20), Height(20), CenterX(0) ]
    }
    
    func makeLabel() {
        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.text = tabDrawerItem.title
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Helvetica", size: 10)
        addSubview(titleLabel)
        titleLabel <- [ Left(0), Right(0), Bottom(5), Height(15) ]
    }
}