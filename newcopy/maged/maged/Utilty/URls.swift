//  URls.swift
//  maged
//  Created by mohamed on 6/20/18.
//  Copyright © 2018 maged. All rights reserved.

import Foundation
struct URLs {
    
    static let main        = "https://etqan.app/admin/Api/"

    static let register_User                = main + "registeration"
    static let login_User                   = main + "login"
    static let Ordres                       = main + "get_client_order"
    static let Edit_profile                 = main + "update_client_details"
    static let get_subsribe_price           = main + "get_subsribe_price"
    static let get_services_list            = main + "get_services_list"
    static let make_subscribe               = main + "make_subscribe"
    static let get_notifcation              = main + "get_notifcation"
    static let get_order_ditail             = main + "get_order_by_id"
    static let update_client_password       = main + "update_client_password"
    static let forget_password              = main + "forget_password"
}
