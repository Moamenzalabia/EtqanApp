//
//  itme_profile.swift
//  project1
//
//  Created by mohamed on 5/28/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
class notifction_Model:Mappable {
    var status:Bool!
    var message:[message_data]!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status    <- map["status"]
        message   <- map["message"]
    }
}
class  message_data:Mappable {
    var id :String!
    var order_id:String!
    var client_id:String!
    var message:String!
    var created_at :String!
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id                           <- map["id"]
        order_id                     <- map["order_id"]
        client_id                    <- map["client_id"]
        message                      <- map["message"]
        created_at                   <- map["created_at"]

    }
    
}



