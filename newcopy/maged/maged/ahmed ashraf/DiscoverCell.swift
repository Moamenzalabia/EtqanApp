//  DiscoverCell.swift
//  maged
//  Created by MOAMEN on 1/17/1398 AP.
//  Copyright © 1398 maged. All rights reserved.

import UIKit

class DiscoverCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImage: UIImageView!
    @IBOutlet weak var finishOutlet: UIButton!
    
    var showDiscover: (() -> ())?
    
    @IBAction func finishButtonAction(_ sender: Any) {
        showDiscover?()
    }
}

