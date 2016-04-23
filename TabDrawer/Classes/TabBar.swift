//
//  TabBar.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import UIKit
import EasyPeasy

protocol TabBarDelegate {
    func selectedItem(item : TabBarItem)
}

class TabBar: UIView {
    
    var tabDrawerItems : [TabDrawerItem]!
    var items : [TabBarItem] = []
    var delegate : TabBarDelegate!
    var configuration : TabDrawerConfiguration!
    
    convenience init(tabDrawerItems : [TabDrawerItem], delegate : TabBarDelegate, config : TabDrawerConfiguration?) {
        self.init(frame : CGRectZero)
        self.tabDrawerItems = tabDrawerItems
        self.delegate = delegate
        self.configuration = config ?? TabDrawerConfiguration.testConfiguration()
        backgroundColor = configuration.tabBarItemBackgroundColor
        for item in tabDrawerItems {
            items.append(TabBarItem(tabDrawerItem: item))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setup() {
        for item in items {
            addSubview(item)
        }
        for i in 0..<items.count {
            if i == 0 {
                items[i] <- [ Left(0), Top(0), Bottom(0), Right(0).to(items[i+1], .Left), Width().like(items[i+1]) ]
            } else if i == items.count - 1 {
                items[i] <- [ Right(0), Top(0), Bottom(0) ]
            } else {
                items[i] <- [ Top(0), Bottom(0), Right(0).to(items[i+1], .Left), Width().like(items[i+1]) ]
            }
        }
        for item in items {
            item.setup()
            item.backgroundColor = configuration.tabBarItemBackgroundColor
            item.titleLabel.font = configuration.tabBarItemTextFont
            item.titleLabel.textColor = configuration.tabBarItemTextColor
            item.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedItem(_:))))
        }
    }
    
    func tappedItem(sender : UITapGestureRecognizer) {
        var count : Int = 0
        if let item = sender.view as? TabBarItem {
            for i in items {
                if i == item {
                    i.backgroundColor = configuration.tabBarItemSelectedBackgroundColor
                    i.titleLabel.textColor = configuration.tabBarItemSelectedTextColor
                    delegate.selectedItem(item)
                } else {
                    i.backgroundColor = configuration.tabBarItemBackgroundColor
                    i.titleLabel.textColor = configuration.tabBarItemTextColor
                }
                count += 1
            }
        }
    }
    
    func setSelectedItem(index : Int) {
        for i in 0..<items.count {
            let item = items[i]
            if index == i {
                item.backgroundColor = configuration.tabBarItemSelectedBackgroundColor
                item.titleLabel.textColor = configuration.tabBarItemSelectedTextColor
            } else {
                item.backgroundColor = configuration.tabBarItemBackgroundColor
                item.titleLabel.textColor = configuration.tabBarItemTextColor
            }
        }
    }
}