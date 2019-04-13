//
//  RoundTextField.swift
//  loginForm
//
//  Created by Hady Hammad on 2/15/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit
@IBDesignable
class RoundTextField:UITextField{
  
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor?{
        didSet{
            backgroundColor = bgColor
        }
    }
    
    @IBInspectable var placeholderColor: UIColor?{
        didSet{
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSAttributedStringKey.foregroundColor:placeholderColor!])
            attributedPlaceholder = str
        }
    }
    
}
