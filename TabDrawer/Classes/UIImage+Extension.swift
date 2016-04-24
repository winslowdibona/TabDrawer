//
//  UIImage+Extension.swift
//  Pods
//
//  Created by Winslow DiBona on 4/24/16.
//
//

import Foundation
import UIKit

public extension UIImage {
    public func size(toSize : CGSize) -> UIImage {
        if CGSizeEqualToSize(size, toSize) {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(toSize, false, 0.0);
        drawInRect(CGRectMake(0.0, 0.0, toSize.width, toSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}

public extension UIImageView {
    public func colorImage(toColor : UIColor) {
        image = image!.imageWithRenderingMode(.AlwaysTemplate)
        tintColor = toColor
    }
    
    public func sizeImage(toSize : CGSize) {
        image = image?.size(toSize)
    }
}
