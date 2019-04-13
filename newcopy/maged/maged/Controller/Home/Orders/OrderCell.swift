//  OrderCell.swift
//  maged
//  Created by Ahmed Ashraf on 2/19/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import HCSStarRatingView
import CoreLocation
class OrderCell: UITableViewCell {
    @IBOutlet weak var serNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var color: UILabel!
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            // Make it card-like
            containerView.layer.cornerRadius = 10
            containerView.layer.shadowOpacity = 1
            containerView.layer.shadowRadius = 2
            containerView.layer.shadowColor = UIColor.lightGray.cgColor
            containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
            containerView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var childContainerView: UIView! {
        didSet {
            // Make it card-like
            childContainerView.layer.cornerRadius = 10
            childContainerView.layer.shadowOpacity = 1
            childContainerView.layer.shadowRadius = 2
            childContainerView.layer.shadowColor = UIColor.lightGray.cgColor
            childContainerView.layer.shadowOffset = CGSize(width: 3, height: 3)
            childContainerView.layer.masksToBounds = true
        }
    }
    
    
    
    func setModel(model: Orders_data) {
        self.serNameLbl.text = model.service_name!
        self.durationLbl.text = model.date!
        self.dateLbl.text = model.from!
        self.statusLbl.text = model.status!
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(model.client_latitude!)")!
        let lon: Double = Double("\(model.client_longitude!)")!
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {(placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                guard let placemark = placemarks?.first else {return}
                let x = placemark.country ?? ""
                let d = placemark.administrativeArea ?? ""
                let l = placemark.subLocality ?? ""
                DispatchQueue.main.async {
                    self.timeLbl.text = "\(l),\(d),\(x)"
                    
                }
        })
    }

}
