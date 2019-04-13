//
//  Localizer.swift
//  Naqelat
//
//  Created by Khaled saad on 11/30/17.
//  Copyright © 2017 Asgatech. All rights reserved.
//

import UIKit

class Localizer: NSObject {
    
    static func localize() {
        
                
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.awakeFromNib), overrideSelector: #selector(UITextField.cstmAwakeFromNib))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.awakeFromNib), overrideSelector: #selector(UILabel.cstmAwakeFromNib))
        MethodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.awakeFromNib), overrideSelector: #selector(UIButton.cstmAwakeFromNib))
        
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(setter: UILabel.text), overrideSelector:#selector(UILabel.customSetText(text:)))
        


    }


}

extension UIApplication {
    
    class func isRTL() -> Bool{
        return Language.currentLanguage == .arabic
    }
}
extension Bundle {
    @objc func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        if self == Bundle.main {
            let currentLanguage = Language.currentLanguage.rawValue
            var bundle = Bundle();
            
            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: _path)!
            } else {
                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
                bundle = Bundle(path: _path)!
            }
            
            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
        } else {
            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
        }
    }
    var localizedMain : Bundle {
        
        get {
            if let path = Bundle.main.path(forResource: UIApplication.isRTL() ? "ar" : "en", ofType: "lproj") {
                
                if let bundle = Bundle.init(path: path) {
                    return bundle
                } else {
                    return Bundle.main
                }
                
            } else {
                return Bundle.main
            }
        }

    }
}

extension UILabel {
    
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
//       let fontName = (self.font?.isBold)! ? ".HelveticaNeueDeskInterface-Bold" : ".HelveticaNeueDeskInterface-Regular"
//       let font = UIFont.init(name: fontName, size: (self.font?.pointSize)!)
//       self.font = font
//
//        self.text = self.text?.localized
//        self.adjustsFontSizeToFitWidth = true
        if self.textAlignment == .center { return }
        
        if UIApplication.isRTL()  {
            if self.textAlignment == .right { return }
            self.textAlignment = .right
        } else {
            if self.textAlignment == .left { return }
            self.textAlignment = .left
        }
    }

    
    @objc func customSetText(text: String) {
        self.customSetText(text: text.localized)
    }


    
}


extension UITextField {
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
//        let fontName = (self.font?.isBold)! ? ".HelveticaNeueDeskInterface-Bold" : ".HelveticaNeueDeskInterface-Regular"
//        let font = UIFont.init(name: fontName, size: (self.font?.pointSize)!)
//        self.font = font
        
        if self.textAlignment == .center { return }

            if UIApplication.isRTL()  {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
    }
}
extension UIButton {
    @objc public func cstmAwakeFromNib() {
        self.cstmAwakeFromNib()
        
//        let fontName = (self.titleLabel?.font?.isBold)! ? ".HelveticaNeueDeskInterface-Bold" : ".HelveticaNeueDeskInterface-Regular"
//        let font = UIFont.init(name: fontName, size: (self.titleLabel?.font?.pointSize)!)
//        self.titleLabel?.font = font
//        
//        
        if self.contentHorizontalAlignment == .center { return }
        
        if UIApplication.isRTL()  {
            if self.contentHorizontalAlignment == .right { return }
            self.contentHorizontalAlignment = .right
        } else {
            if self.contentHorizontalAlignment == .left { return }
            self.contentHorizontalAlignment = .left
        }
    }
}
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}



