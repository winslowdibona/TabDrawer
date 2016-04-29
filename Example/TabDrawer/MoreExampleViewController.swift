//
//  MoreExampleViewController.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import TabDrawer
import FontAwesome_swift

class MoreExampleViewController: UIViewController {
    
    var textLabel : UILabel!
    var tabDrawer : TabDrawer!
    var moreOption : [String] = ["Profile", "Settings", "Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor()
        let config = TabDrawerConfiguration.defaultConfiguration()
        makeLabel()
        tabDrawer = TabDrawer(items: makeItems(), config: config)
        tabDrawer.placeOn(view)
    }
    
    func makeItems() -> [TabDrawerItem] {
        let homeItem = TabDrawerItem(icon: UIImage.fontAwesomeIconWithName(.Home, textColor: .whiteColor(), size: CGSizeMake(20, 20)), title: "Home", selectionBlock: {
            self.textLabel.text = "Home"
        })
        let messagesItem = TabDrawerItem(icon: UIImage.fontAwesomeIconWithName(.Inbox, textColor: .whiteColor(), size: CGSizeMake(20, 20)), title: "Messages") {
            self.textLabel.text = "Messages"
        }
        let notificationsItem = TabDrawerItem(icon: UIImage.fontAwesomeIconWithName(.ExclamationCircle, textColor: .whiteColor(), size: CGSizeMake(20, 20)), title: "Notifications") {
            self.textLabel.text = "Notifications"
        }
        let profileOption = TabDrawerItemOption(title: "Profile") { 
            self.textLabel.text = "Profile"
        }
        let settingsOption = TabDrawerItemOption(title: "Settings") {
            self.textLabel.text = "Settings"
        }
        let logoutOption = TabDrawerItemOption(title: "Logout") {
            self.textLabel.text = "Logout"
        }
        let moreItem = TabDrawerItem(icon: UIImage.fontAwesomeIconWithName(.EllipsisH, textColor: .whiteColor(), size: CGSizeMake(20, 20)), title: "More", options: [profileOption, settingsOption, logoutOption])
        return [homeItem, messagesItem, notificationsItem, moreItem]
    }
    
    
    func makeLabel() {
        textLabel = UILabel(frame: CGRectZero)
        textLabel.textAlignment = .Center
        view.addSubview(textLabel)
        textLabel <- [Left(5), Right(5), Center()]
    }
    
}
