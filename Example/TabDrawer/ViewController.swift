//
//  ViewController.swift
//  TabDrawer
//
//  Created by winslowdibona on 04/23/2016.
//  Copyright (c) 2016 winslowdibona. All rights reserved.
//

import UIKit
import TabDrawer

class ViewController: UIViewController {
    
    var tabDrawer : TabDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        let config = TabDrawerConfiguration.defaultConfiguration()
        let redView = UIView(frame : CGRectZero)
        redView.addGestureRecognizer(tap)
        let blueView = UIView(frame: CGRectZero)
        blueView.addGestureRecognizer(tap)
        let greenView = UIView(frame: CGRectZero)
        greenView.addGestureRecognizer(tap)
        redView.backgroundColor = config.drawerBackgroundColor
        blueView.backgroundColor = config.drawerBackgroundColor
        greenView.backgroundColor = config.drawerBackgroundColor
        let o = TabDrawerItemOption(title: "option") {
            print("option tapped")
            self.tabDrawer.lower({
                
            })
        }
        let o2 = TabDrawerItemOption(title: "option 2") {
            print("option 2 tapped")
            self.tabDrawer.lower({
                
            })
        }
        let item = TabDrawerItem(icon: UIImage(named: "home")!, title: "Red View", view: redView, viewHeight: 100)
        let item2 = TabDrawerItem(icon: UIImage(named: "home")!, title: "Blue View", view: blueView, viewHeight: 200)
        let item3 = TabDrawerItem(icon: UIImage(named: "home")!, title: "Green View", view: greenView, viewHeight: 150)
        let item4 = TabDrawerItem(icon: UIImage(named: "home")!, title: "Options", options: [o, o2])
        tabDrawer = TabDrawer(items: [item, item2, item3, item4], config: config)
        tabDrawer.placeOn(view)
    }
    
    func tapped(sender : UITapGestureRecognizer) {
        tabDrawer.lower {
            
        }
    }
}