//
//  TabDrawer.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import UIKit
import EasyPeasy

class TabDrawer : UIView {
    
    var items : [TabDrawerItem] = []
    var mask : UIView!
    var displayedOptions : [TabDrawerItemOption] = []
    var raised : Bool = false
    var view : UIView!
    var previouslySelectedItem : UITabBarItem!
    var optionCount : Int = 0
    var tabBar : TabBar!
    var previousItem : TabBarItem!
    var configuration : TabDrawerConfiguration!
    var drawer : Drawer!
    var selectedIndex : Int = 0
    var closeBlock : (() -> Void)?
    var openBlock : (() -> Void)?
    
    convenience init(items : [TabDrawerItem], config : TabDrawerConfiguration?) {
        self.init(frame : CGRectZero)
        self.items = items
        self.configuration = config ?? TabDrawerConfiguration.defaultConfiguration()
    }
    
    override init(frame : CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func placeOn(view : UIView) {
        self.view = view
        view.addSubview(self)
        self <- [ Left(0), Right(0), Bottom(0), Height(49) ]
        makeMask()
        makeDrawer()
        makeTabBar()
        let v = UIView(frame: CGRectZero)
        v.backgroundColor = UIColor.lightGrayColor()
        addSubview(v)
        v <- [Left(0), Right(0), Top(0), Height(1)]
    }
    
    func makeTabBar() {
        tabBar = TabBar(tabDrawerItems: self.items, delegate: self, config: configuration)
        addSubview(tabBar)
        tabBar <- [ Left(0), Right(0), Top(0), Bottom(0).to(drawer, .Top) ]
        tabBar.setup()
        previousItem = tabBar.items[0]
    }
    
    func makeDrawer() {
        drawer = Drawer(tabDrawerItems: items, delegate: self, configuration: configuration)
        addSubview(drawer)
        drawer <- [ Left(0), Right(0), Bottom(0), Height(0) ]
        drawer.setup()
    }
    
    func makeMask() {
        mask = UIView(frame: CGRectZero)
        mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        mask.opaque = false
        mask.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(maskTapped(_:))))
        view.addSubview(mask)
        mask <- [Left(0), Right(0), Top(0), Bottom(0)]
        mask.removeFromSuperview()
    }
    
    func maskTapped(sender : UITapGestureRecognizer) {
        lower {}
    }
}

extension TabDrawer : DrawerDelegate {
    func selectedOption() {
        lower {}
    }
    
    func scrolledTo(index: Int) {
        tabBar.setSelectedItem(index)
        previousItem = tabBar.items[index]
    }
    
    func transitioningToHeight(height: CGFloat, animationBlock: (() -> Void)) {
        UIView.animateWithDuration(0.2) { 
            self <- Height(height + 49)
            animationBlock()
            self.view.layoutIfNeeded()
        }
    }
}

extension TabDrawer : TabBarDelegate {
    
    func selectedItem(item: TabBarItem) {
        let index = tabItemIndex(item)
        selectedIndex = index
        let drawerItem = items[index]
        if let block = drawerItem.selectionBlock {
            block()
        } else {
            if raised {
                if item == previousItem {
                    lower {}
                } else {
                    self.previousItem = item
                    drawer.scrollTo(index)
                }
            } else {
                previousItem = item
                raise {
                    self.drawer.scrollTo(index)
                }
            }
        }
    }
    
    func raise(completion : (() -> Void)?) {
        raised = true
        view.insertSubview(mask, belowSubview: self)
        mask <- [Left(0), Right(0), Top(0), Bottom(0)]
        UIView.animateWithDuration(0.3, animations: {
            self.mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            self <- Height(149)
            self.drawer <- Height(100)
            self.view.layoutIfNeeded()
            }) { (success) in
                completion?()
                self.openBlock?()
        }
    }
    
    func lower(completion : (() -> Void)?) {
        raised = false
        UIView.animateWithDuration(0.1, animations: { 
            self.mask.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            }) { (s) in
                self.mask.removeFromSuperview()
                UIView.animateWithDuration(0.3, animations: {
                    self <- Height(49)
                    self.drawer <- Height(0)
                    self.view.layoutIfNeeded()
                }) { (success) in
                    completion?()
                    self.closeBlock?()
                }
        }
    }
    
    func tabItemIndex(tabBarItem : TabBarItem) -> Int {
        var i = 0
        for item in tabBar.items {
            if item == tabBarItem {
                return i
            }
            i += 1
        }
        return i
    }
}