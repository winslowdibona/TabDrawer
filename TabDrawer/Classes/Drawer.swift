//
//  Drawer.swift
//  TabDrawer
//
//  Created by Winslow DiBona on 4/22/16.
//  Copyright © 2016 expandshare. All rights reserved.
//

import UIKit
//import EasyPeasy

protocol DrawerDelegate {
    func selectedOption()
    func scrolledTo(index : Int)
    func transitioningToHeight(height : CGFloat, animationBlock : (() -> Void))
}

class Drawer: UIView {
    
    var tabDrawerItems : [TabDrawerItem] = []
    var delegate : DrawerDelegate!
    var tableViews : [UITableView] = []
    var configuration : TabDrawerConfiguration!
    var collectionView : UICollectionView!
    var currentCellIndex : Int = 0
    
    convenience init(tabDrawerItems : [TabDrawerItem], delegate : DrawerDelegate, configuration : TabDrawerConfiguration) {
        self.init(frame : CGRectZero)
        self.tabDrawerItems = tabDrawerItems
        self.delegate = delegate
        self.configuration = configuration
        self.backgroundColor = configuration.drawerBackgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setup() {
        makeCollectionView()
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
}

extension Drawer : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabDrawerItems.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.frame.size.width, tabDrawerItems[indexPath.row].viewHeight!)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        cell.addSubview(tabDrawerItems[indexPath.row].view!)
        tabDrawerItems[indexPath.row].view! <- [ Left(0), Right(0), Top(0), Bottom(0) ]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        delegate.transitioningToHeight(tabDrawerItems[indexPath.row].viewHeight!) { 
            self <- Height(self.tabDrawerItems[indexPath.row].viewHeight!)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        for v in cell.subviews {
            v.removeFromSuperview()
        }
    }
    
    func scrollTo(index : Int) {
        if index != currentCellIndex {
            currentCellIndex = index
        }
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0), atScrollPosition: .CenteredHorizontally, animated: true)
        delegate.transitioningToHeight(tabDrawerItems[index].viewHeight!) { 
            self <- Height(self.tabDrawerItems[index].viewHeight!)
        }
    }
    
    func swiped(sender : UISwipeGestureRecognizer) {
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