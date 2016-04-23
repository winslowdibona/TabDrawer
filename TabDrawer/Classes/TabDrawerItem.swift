//
//  TabDrawerItem.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import Foundation
import UIKit

struct TabDrawerItemOption {
    var title : String?
    var selectionBlock : (() -> Void)?
}

class TabDrawerItem {
    var icon : UIImage?
    var title : String?
    var selectionBlock : (() -> Void)?
    var view : UIView?
    var options : [TabDrawerItemOption] = []
    var viewHeight : CGFloat?
    
    init(icon : UIImage, title : String, selectionBlock : (() -> Void)) {
        self.icon = icon
        self.title = title
        self.selectionBlock = selectionBlock
    }
    
    init(icon : UIImage, title : String, options : [TabDrawerItemOption]) {
        self.icon = icon
        self.title = title
        self.options = options
    }
    
    init(icon : UIImage, title : String, view : UIView, viewHeight : CGFloat) {
        self.icon = icon
        self.title = title
        self.view = view
        self.viewHeight = viewHeight
    }
}