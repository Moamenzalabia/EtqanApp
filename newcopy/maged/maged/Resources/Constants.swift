//
//  Contants.swift
//  Challenge_App
//
//  Created by Khaled saad on 12/17/17.
//  Copyright © 2017 Asgatech. All rights reserved.
//

import UIKit

class Constants: NSObject {

    static var Lan = "en"
    static let adminEmail = "ADMIN@ITPHARAOHS.COM"
    static let adminPass = "P@$$w0rdItp121314213141"
    static let greenColorCode = "#009D7D"
    static let twitterConsumerKey = "1yx3k0ML0BqCwCwGCSyJT86hb"
    static let twitterConsumerSecret = "ylKFuG3t8zw4ASTT2yg2QyxgmLoVifA1L7y2yfH9vnuG5TOBlH"
    static var energyGaol: Double? {
        if let target = Cache.object(key: "caloriesTarget") as? Int  {
            return Double(target)
        }
        return nil
    }
    static let defaultTarget: Double =   400 
    static let generalCompetitionID = "6c99a4f3-2176-44cf-b4c9-b2d09e5ad7b5"

//    static let  serverIP = "http://196.218.95.94"
//    static let  serverIP = "http://197.44.170.157"
//    static let  serverIP = "http://192.168.1.7"
//    static let  serverIP = "http://197.44.170.157"
//    static let  serverIP = "http://196.218.95.83"
    static let  serverIP = "http://41.131.107.13"



}
