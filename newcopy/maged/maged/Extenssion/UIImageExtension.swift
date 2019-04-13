//
//  UIImageExtension.swift
//  Challenge_App
//
//  Created by Khaled saad on 12/18/17.
//  Copyright © 2017 Asgatech. All rights reserved.
//

import UIKit


extension UIImage {
    
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    class func imageWithInitials(initials : String, size : CGSize) -> UIImage {
        
        let imageview = UIImageView.init(frame: CGRect.init(origin: .zero, size: size))
        imageview.setImage(string: initials, color:UIColor.init(hexString: Constants.greenColorCode), circular: true, textAttributes: nil)
        
        return imageview.image!
        
    }
    func base64() -> String {
        
        let imageData = UIImageJPEGRepresentation(self, 0.4)!
        return imageData.base64EncodedString()
    }

    
}
