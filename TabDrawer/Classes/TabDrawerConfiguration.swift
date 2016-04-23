//
//  TabDrawerConfiguration.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import Foundation
import UIKit

public struct TabDrawerConfiguration {
    public var drawerBackgroundColor : UIColor?
    public var drawerTextFont : UIFont?
    public var drawerTextColor : UIColor?
    public var tabBarItemBackgroundColor : UIColor?
    public var tabBarItemSelectedBackgroundColor : UIColor?
    public var tabBarItemTextColor : UIColor?
    public var tabBarItemSelectedTextColor : UIColor?
    public var tabBarItemTextFont : UIFont?
    public var tabBarItemIconColor : UIColor?
    public var tabBarItemIconSelectedColor : UIColor?
    public init(){}
    
    public static func testConfiguration() -> TabDrawerConfiguration {
        var config = TabDrawerConfiguration()
        config.drawerBackgroundColor = UIColor(red: 90/255, green: 125/255, blue: 124/255, alpha: 1.0)
        config.drawerTextColor = .whiteColor()
        config.drawerTextFont = UIFont(name: "Helvetica", size: 15)
        config.tabBarItemBackgroundColor = .whiteColor()
        config.tabBarItemSelectedBackgroundColor = UIColor(red: 90/255, green: 125/255, blue: 124/255, alpha: 1.0)
        config.tabBarItemTextColor = .lightGrayColor()
        config.tabBarItemSelectedTextColor = .whiteColor()
        config.tabBarItemTextFont = UIFont(name: "Helvetica", size: 10)
        config.tabBarItemIconColor = UIColor(red: 90/255, green: 125/255, blue: 124/255, alpha: 1.0)
        config.tabBarItemIconSelectedColor = .whiteColor()
        return config
    }
    
    public static func defaultConfiguration() -> TabDrawerConfiguration {
        let blueColor = UIColor(red: 49/255, green: 153/255, blue: 255/255, alpha: 1.0)
        var config = TabDrawerConfiguration()
        config.drawerBackgroundColor = blueColor
        config.drawerTextColor = .whiteColor()
        config.drawerTextFont = UIFont(name: "Helvetica", size: 15)
        config.tabBarItemBackgroundColor = .whiteColor()
        config.tabBarItemIconColor = .lightGrayColor()
        config.tabBarItemIconSelectedColor = .whiteColor()
        config.tabBarItemSelectedBackgroundColor = blueColor
        config.tabBarItemTextFont = UIFont(name: "Helvetica", size: 15)
        config.tabBarItemTextColor = .lightGrayColor()
        config.tabBarItemSelectedTextColor = .whiteColor()
        return config
    }
}