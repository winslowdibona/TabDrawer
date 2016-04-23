//
//  TabDrawerItem.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import Foundation
import UIKit

public struct TabDrawerItemOption {
    public var title : String?
    public var selectionBlock : (() -> Void)?
    
    public init(title : String, selectionBlock : (() -> Void)) {
        self.title = title
        self.selectionBlock = selectionBlock
    }
}

public class TabDrawerItem {
    public var icon : UIImage?
    public var title : String?
    public var selectionBlock : (() -> Void)?
    public var view : UIView?
    public var options : [TabDrawerItemOption] = []
    public var viewHeight : CGFloat? = 125
    
    public init(icon : UIImage, title : String, selectionBlock : (() -> Void)) {
        self.icon = icon
        self.title = title
        self.selectionBlock = selectionBlock
    }
    
    public init(icon : UIImage, title : String, options : [TabDrawerItemOption]) {
        self.icon = icon
        self.title = title
        self.options = options
    }
    
    public init(icon : UIImage, title : String, view : UIView, viewHeight : CGFloat) {
        self.icon = icon
        self.title = title
        self.view = view
        self.viewHeight = viewHeight
    }
}