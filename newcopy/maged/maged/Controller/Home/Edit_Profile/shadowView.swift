//  shadowView.swift
//  maged
//  Created by MOAMEN on 12/25/1397 AP.
//  Copyright © 1397 maged. All rights reserved.


import UIKit

class shadowView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)

    }

}
