//
//  UIViewExtensions.swift
//  Challenge_App
//
//  Created by Khaled saad on 1/22/18.
//  Copyright © 2018 Asgatech. All rights reserved.
//

import UIKit

extension UIView {

    func screenshot() -> UIImage? {
//
//        UIGraphicsBeginImageContext(self.frame.size)
//        self.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//        return image
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
       drawHierarchy(in: bounds, afterScreenUpdates: true)
       let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()
       return newImage
    }

}
