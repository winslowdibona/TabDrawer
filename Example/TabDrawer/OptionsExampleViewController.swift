//
//  OptionsExampleViewController.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/23/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import TabDrawer

class OptionsExampleViewController: UIViewController {
    
    var tabDrawer : TabDrawer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = TabDrawerConfiguration.defaultConfiguration()
        let items = makeItems()
        tabDrawer = TabDrawer(items: items, config: config)
        tabDrawer.placeOn(view)
    }
    
    func makeItems() -> [TabDrawerItem] {
        var temp : [TabDrawerItem] = []
        let options1 = makeDefaultOptions(["My Team", "All Activity"])
        temp.append(TabDrawerItem(icon: UIImage(named: "List")!, title: "Activity", options: options1))
        let options2 = makeDefaultOptions(["Create New Issue", "My Open Issues", "My Team's Issues"])
        temp.append(TabDrawerItem(icon: UIImage(named: "Checkbox")!, title: "Queue", options: options2))
        let options3 = makeDefaultOptions(["New Message", "My Inbox", "Team Chat"])
        temp.append(TabDrawerItem(icon: UIImage(named: "Chat")!, title: "Chat", options: options3))
        let options4 = makeDefaultOptions(["My Productivity", "Team Tracking", "Cost Analysis"])
        temp.append(TabDrawerItem(icon: UIImage(named: "Graph")!, title: "Reports", options: options4))
        let options5 = makeDefaultOptions(["My Profile", "Team Settings", "Logout"])
        temp.append(TabDrawerItem(icon: UIImage(named: "Settings")!, title: "Settings", options: options5))
        return temp
    }
    
    func makeDefaultOptions(titles : [String]) -> [TabDrawerItemOption] {
        var temp : [TabDrawerItemOption] = []
        for title in titles {
            temp.append(makeDefaultOption(title))
        }
        return temp
    }
    
    func makeDefaultOption(title : String) -> TabDrawerItemOption {
        let option = TabDrawerItemOption(title: title) { 
            self.tabDrawer.lower(nil)
        }
        return option
    }
}
