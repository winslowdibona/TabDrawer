//
//  ViewController.swift
//  TabDrawer
//
//  Created by winslowdibona on 04/23/2016.
//  Copyright (c) 2016 winslowdibona. All rights reserved.
//

import UIKit
import TabDrawer

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var examples : [String] = ["Options", "More"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = examples[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let vc = OptionsExampleViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = MoreExampleViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}