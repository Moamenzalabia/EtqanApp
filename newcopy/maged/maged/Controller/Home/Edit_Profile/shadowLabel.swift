//  shadowLabel.swift
//  maged
//  Created by MOAMEN on 1/17/1398 AP.
//  Copyright © 1398 maged. All rights reserved.


import UIKit

class shadowLabel: UILabel {

    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        
    }
    

}
