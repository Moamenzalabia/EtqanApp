//  UIColorExtention.swift
//  maged
//  Created by MOAMEN on 12/20/1397 AP.
//  Copyright © 1397 maged. All rights reserved.

import Foundation
import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        
     }
}
