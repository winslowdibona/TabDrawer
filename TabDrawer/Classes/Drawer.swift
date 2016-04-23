//
//  Drawer.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import UIKit

public protocol DrawerDelegate {
    func selectedOption()
    func scrolledTo(index : Int)
    func transitioningToHeight(height : CGFloat)
    func transitioningToSize(size : CGFloat)
}

public class Drawer: UIView {
    
    public var tabDrawerItems : [TabDrawerItem] = []
    public var delegate : DrawerDelegate!
    public var tableViews : [UITableView] = []
    public var configuration : TabDrawerConfiguration!
    public var collectionView : UICollectionView!
    public var currentCellIndex : Int = 0
    
    convenience public init(tabDrawerItems : [TabDrawerItem], delegate : DrawerDelegate, configuration : TabDrawerConfiguration) {
        self.init(frame : CGRectZero)
        self.tabDrawerItems = tabDrawerItems
        self.delegate = delegate
        self.configuration = configuration
        self.backgroundColor = configuration.drawerBackgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public func setup() {
        makeCollectionView()
        for item in tabDrawerItems {
            if item.view == nil && item.options.count > 0 {
                item.view = makeTableView()
            }
        }
        collectionView.reloadData()
    }
    
    func makeCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.pagingEnabled = true
        collectionView.alwaysBounceVertical = false
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.scrollEnabled = false
        collectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let swipe1 = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        let swipe2 = UISwipeGestureRecognizer(target: self, action: #selector(swiped(_:)))
        swipe1.direction = .Left
        swipe2.direction = .Right
        collectionView.addGestureRecognizer(swipe1)
        collectionView.addGestureRecognizer(swipe2)
        addSubview(collectionView)
        collectionView <- [ Left(0), Right(0), Top(0), Bottom(0) ]
    }
    
    func makeTableView() -> UITableView {
        let tv = UITableView(frame: CGRectZero)
        tv.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        tv.separatorStyle = .None
        tv.delegate = self
        tv.dataSource = self
        tv.scrollEnabled = false
        return tv
    }
}

extension Drawer : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabDrawerItems.count
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, tabDrawerItems[indexPath.row].viewHeight!)
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cell.addSubview(tabDrawerItems[indexPath.row].view!)
        tabDrawerItems[indexPath.row].view! <- [ Left(0), Right(0), Top(0), Bottom(0) ]
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        delegate.transitioningToHeight(tabDrawerItems[indexPath.row].viewHeight!)
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        for v in cell.subviews {
            v.removeFromSuperview()
        }
    }
    
    public func scrollTo(index : Int) {
        if index != currentCellIndex {
            currentCellIndex = index
        }
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
        delegate.transitioningToHeight(tabDrawerItems[index].viewHeight!)
    }
    
    public func swiped(sender : UISwipeGestureRecognizer) {
        if sender.direction == .Left {
            if currentCellIndex != tabDrawerItems.count - 1 {
                currentCellIndex += 1
            }
        } else {
            if currentCellIndex != 0 {
                currentCellIndex -= 1
            }
        }
        scrollTo(currentCellIndex)
        delegate.scrolledTo(currentCellIndex)
    }
}

extension Drawer : UITableViewDelegate, UITableViewDataSource {
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabDrawerItems[indexForTableView(tableView)].options.count
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .None
        cell.textLabel?.font = configuration.drawerTextFont
        cell.textLabel?.textColor = configuration.drawerTextColor
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.text = tabDrawerItems[indexForTableView(tableView)].options[indexPath.row].title
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        return cell
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tabDrawerItems[indexForTableView(tableView)].options[indexPath.row].selectionBlock?()
    }
    
    public func indexForTableView(tableView : UITableView) -> Int {
        var i = 0
        for item in tabDrawerItems {
            if let tv = item.view as? UITableView {
                if tv == tableView {
                    return i
                }
            }
            i += 1
        }
        return 0
    }
}