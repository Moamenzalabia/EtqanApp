//
//  itme_profile.swift
//  project1
//
//  Created by mohamed on 5/28/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import ObjectMapper
class Orders_Model:Mappable {
    var status:Bool!
    var Data:[Orders_data]!
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        status <- map["status"]
        Data   <- map["message"]
    }
}
class  Orders_data:Mappable {
    var id :String!
    var date:String!
    var from:String!
    var to:String!
    var representative_id:String!
    var status:String!
    var gender:String!
    var service_id:String!
    var order_num:String!
    var total_price:String!
    var supervisor_latitude:String!
    var supervisor_longitude:String!
    var client_latitude:String!
    var client_longitude:String!
    var team_num:String!
    var home_name:String!
    var car_name:String!
    var group_name:String!
    var nationality_name:String!
    var supervisor_name:String!
    var service_name:String!
    var team_name:String!
    var client_name:String!
    var ontime_rate:String!
    var quality_rate:String!
    var team_rate:String!
    var comment:String!
    var avg_rate:String!
    var full_address:String!
    var status_name_space :String!
    required init?(map: Map) {}

    func mapping(map: Map) {
        id                      <- map["id"]
        date                    <- map["date"]
        from                    <- map["from"]
        to                      <- map["to"]
        representative_id       <- map["representative_id"]
        status                  <- map["status"]
        gender                  <- map["gender"]
        service_id              <- map["service_id"]
        order_num               <- map["order_num"]
        total_price             <- map["total_price"]
        supervisor_latitude     <- map["supervisor_latitude"]
        supervisor_longitude    <- map["supervisor_longitude"]
        client_latitude         <- map["client_latitude"]
        client_longitude        <- map["client_longitude"]
        team_num                <- map["team_num"]
        home_name               <- map["home_name"]
        car_name                <- map["car_name"]
        group_name              <- map["group_name"]
        nationality_name        <- map["nationality_name"]
        supervisor_name         <- map["supervisor_name"]
        service_name            <- map["service_name"]
        team_name               <- map["team_name"]
        client_name             <- map["client_name"]
        ontime_rate             <- map["ontime_rate"]
        quality_rate            <- map["quality_rate"]
        team_rate               <- map["team_rate"]
        comment                 <- map["comment"]
        avg_rate                <- map["avg_rate"]
        status_name_space       <- map["status_name_space"]
        full_address            <- map["full_address"]


    }
    
}



