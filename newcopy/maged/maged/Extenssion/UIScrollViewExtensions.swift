//
//  UIScrollViewExtensions.swift
//  Challenge_App
//
//  Created by Khaled saad on 1/22/18.
//  Copyright © 2018 Asgatech. All rights reserved.
//

import UIKit

extension UIScrollView {

    func snapshot() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContextWithOptions(self.contentSize, false, 0)
        do {
            let savedContentOffset: CGPoint = self.contentOffset
            let savedFrame: CGRect = self.frame
            self.contentOffset = CGPoint.zero
            self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            image = UIGraphicsGetImageFromCurrentImageContext()
            self.contentOffset = savedContentOffset
            self.frame = savedFrame
        }
        UIGraphicsEndImageContext()
        
//        UIGraphicsBeginImageContext(self.contentSize)
//
//        let savedContentOffset = self.contentOffset
//        let savedFrame = self.frame
//
//        self.contentOffset = CGPoint.zero
//
//        self.frame = CGRect(x: 0, y: 0, width: self.contentSize.width, height: self.contentSize.height)
//
//        self.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//
//
//        UIGraphicsEndImageContext()
//
//        self.contentOffset = savedContentOffset
//        self.frame = savedFrame
//
        return image
    }

}
