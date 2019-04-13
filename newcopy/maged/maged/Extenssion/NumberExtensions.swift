//
//  NumberExtensions.swift
//  Challenge_App
//
//  Created by Khaled saad on 1/23/18.
//  Copyright © 2018 Asgatech. All rights reserved.
//

import UIKit

extension Int {
    func string(style: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: Language.currentLanguage.rawValue)
        formatter.numberStyle = style
        formatter.maximumFractionDigits = 0;
        let number = NSNumber.init(value: self)
        return formatter.string(from: number)!
    }
}
