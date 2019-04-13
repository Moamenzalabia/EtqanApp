//
//  My_itmes.swift
//  project1
//
//  Created by mohamed on 6/3/18.
//  Copyright © 2018 Dev. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import ObjectMapper

class API {
    
    class func Update_profile (
        lang:String,
        gender:String,
        client_id:String,
        nameAR:String,
        nameEN:String,
        email :String,
        phone:String,
        mobile:String,
        completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?, _ message: String?)->Void) {
        let url = URLs.Edit_profile
        let parameters =
            [
                "lang"          :Constants.Lan,
                "gender"        :gender,
                "client_id"     :client_id,
                "nameAR"        :nameAR,
                "nameEN"        :nameEN,
                "email"         :email,
                "phone"         :phone,
                "mobile"        :mobile,
            ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    print("error1")
                    completion(error,false,nil,nil)
                    print(error)
                case .success(_):
                    print(" No error")
                    let json = JSON(res.result.value)
                    print(json)
                    let status = json["status"].bool
                    let message = json["message"].string
                    
                    completion(nil,true,status,message)
                    
                }
        }    }
    
    class func Update_Password (
        new_password:String,
        client_id:String,
        old_password:String,
        completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?, _ message: String?)->Void) {
        let url = URLs.update_client_password
        let parameters =
            [
                "lang"          :Constants.Lan,
                "client_id"     :client_id,
                "old_password"  :old_password,
                "new_password"  :new_password
            ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    print("error1")
                    completion(error,false,nil,nil)
                    print(error)
                case .success(_):
                    print(" No error")
                    let json = JSON(res.result.value)
                    print(json)
                    let status = json["status"].bool
                    let message = json["message"].string
                    
                    completion(nil,true,status,message)
                    
                }
        }    }
    
    class func My_itmes (
        lang:String,
        client_id:String,
        completion: @escaping (_ error: Error?, _ success: Bool,_ jsonData: AnyObject?)->Void) {
        let url = URLs.Ordres
        let params = ["lang":Constants.Lan,"client_id":client_id]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,false,nil)
                    print(error)
                case .success(_):
                   let json = res.result.value as! Dictionary<String,AnyObject>
                   print(json["status"]!)
                   UserDefaults.standard.set(json["status"]!, forKey: "Y")
                   print(json)
                    
                    let model = Mapper<Orders_Model>().map(JSONObject:res.result.value)
                    completion(nil,true,model)
                }
        }
    }
    
    class func Get_notifction (
        lang:String,
        client_id:String,
        completion: @escaping (_ error: Error?, _ success: Bool,_ jsonData: AnyObject?)->Void) {
        let url = URLs.get_notifcation
        let params = ["lang":Constants.Lan,"client_id":client_id]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,false,nil)
                    print(error)
                case .success(_):
                    let json = res.result.value!
                    print(json)
                    
                    let model = Mapper<notifction_Model>().map(JSONObject:res.result.value)
                    completion(nil,true,model)
                    
                }
        }
    }
    
    
    
    // MARK: Edit_profile Funcs
    class func Edit_profile (lang:String,client_id:String,completion: @escaping (_ error: Error?, _ success: Bool,_ jsonData: AnyObject?)->Void) {
        let url = URLs.Ordres
        let params = ["lang":Constants.Lan,"client_id":"20"]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,false,nil)
                    print(error)
                case .success(_):
                    let json = JSON(res.result.value)
                    print(json)

                    
                    let model = Mapper<Orders_Model>().map(JSONObject:res.result.value)
                    completion(nil,true,model)
                    
                }
        }
    }
    
    // MARK: Make Subscribe Funcs
    
    class func Get_price (
        lang:String,
        gender:String,
        service_id:String,
        employees_num:String,
        hours_number:String,
        days:[String],
        duration:Int,
        completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?, _ message: Int?)->Void) {
        let url = URLs.get_subsribe_price
        let params =
            [
            "lang"          :Constants.Lan,
            "gender"        :gender,
            "service_id"    :service_id,
            "employees_num" :employees_num,
            "hours_number"  :hours_number,
            "days"          :"\(days)",
            "duration"      :duration
                ] as [String : Any] 
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                     print("error1")
                    completion(error,false,nil,nil)
                    print(error)
                case .success(_):
                    print(" No error")
                    let json = JSON(res.result.value)
                    print(json)
                    let status = json["status"].bool
                    let message = json["message"]["total_price"].int

                    completion(nil,true,status,message)
                    
                }
        }
    }
    
    class func List_service (lang:String,completion: @escaping (_ error: Error?, _ success: Bool,_ No3_list: [String]?)->Void) {
        var get_services_list:[String] = [String]()
        let url = URLs.get_services_list
        let parameters =
            ["lang" :lang]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,false,nil)
                    print(error)
                case .success(let value):
                    let json = JSON(value)
                    // print(json)
                    let data = json["message"]
                    for (index, object) in data {
                        let name = object["name"].stringValue
                        get_services_list.append(name)
                        print(name)
                    }
                    print(get_services_list)
                    completion(nil,true,get_services_list)
                }
                
        }
    }

    class func make_subscribe (
        lang:String,
        gender:String,
        service_id:String,
        hours_number:String,
        days:[String],
        duration:Int,
        client_id:String,
        latitude:String,
        longitude:String,
        time_from :String,
        date:String,
        team_number:String,
        completion: @escaping (_ error: Error?, _ success: Bool, _ status: Bool?, _ message: String?)->Void) {
        let url = URLs.make_subscribe
        let parameters =
            [
                "lang"          :Constants.Lan,
                "gender"        :gender,
                "service_id"    :service_id,
                "hours_number"  :hours_number,
                "days"          :"\(days)",
                "duration"      :duration,
                "client_id"     :client_id,
                "latitude"      :latitude,
                "longitude"     :longitude,
                "time_from"     :time_from,
                "date"          :date,
                "team_number"   :team_number,
                ] as [String : Any]
     print("///////////////////////////////////////////")
        print(parameters)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    print("error1")
                    print("moamen>>>>>", error.localizedDescription)
                    completion(error,false,nil,nil)
                    print(error)
                case .success(_):
                    print(" No error")
                    let json = JSON(res.result.value!)
                    print(json)
                    let status = json["status"].bool
                    let message = json["message"].string
                    
                    completion(nil,true,status,message)
                    
                }
        }    }
    

    class func get_orderDitial (
        order_id:String,

        completion: @escaping (_ error: Error?,
        _ success: Bool,
        _ status: Bool?,
        _ to : String?,
        _ date: String?,
        _ statu: String?,
        _ supervisor_latitude: String?,
        _ supervisor_longitude: String?,
        _ client_latitude: String?,
        _ client_longitude: String?)->Void) {
        let url = URLs.get_order_ditail
        let parameters =
            [
                "lang"      :Constants.Lan,
                "order_id"  :order_id
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    print("error1")
                    completion(error,false,nil,nil,nil,nil,nil,nil,nil,nil)
                    print(error)
                case .success(_):
                    print(" No error")
                    let json = JSON(res.result.value)
                    print(json)
                    let status = json["status"].bool
                    let to = json["message"]["to"].string
                    let created_at = json["message"]["created_at"].string
                    let service_name = json["message"]["service_name"].string
                    let supervisor_latitude = json["message"]["supervisor_latitude"].string
                    let supervisor_longitude = json["message"]["supervisor_longitude"].string
                    let client_latitude = json["message"]["client_latitude"].string
                    let client_longitude = json["message"]["client_longitude"].string

                    completion(nil,true,status,to,created_at,service_name,supervisor_latitude,supervisor_longitude,client_latitude,client_longitude)
                    
                }
        }    }
}



