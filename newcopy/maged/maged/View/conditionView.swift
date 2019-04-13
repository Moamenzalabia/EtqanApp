//  conditionView.swift
//  maged
//  Created by MOAMEN on 12/3/2019 AP.
//  Copyright © 1397 maged. All rights reserved.

import UIKit

class  conditionView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 15
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor.rgb(red: 225, green: 126, blue: 136).cgColor
    }
    
}
