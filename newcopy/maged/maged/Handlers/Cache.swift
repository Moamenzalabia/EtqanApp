//
//  Cache.swift
//  Challenge_App
//
//  Created by Khaled saad on 12/17/17.
//  Copyright © 2017 Asgatech. All rights reserved.
//

import UIKit

class Cache: NSObject {
    
    static var token : String? {
        get {
            return Cache.object(key: "token") as? String 
                
        }
    }
    static var isTutorialShown : Bool {
        get {
            return Cache.object(key: "isTutorialShown") != nil
        }
        set (isShown){
            if isShown {
                Cache.set(object: isShown, forKey: "isTutorialShown")
            } else {
                Cache.removeObject(key: "isTutorialShown")
            }
        }
    }
    
    private static func archiveUserInfo(info : Any) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: info) as NSData
    }
    
    class func object(key:String) -> Any? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: key) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data)
        }
        
        return nil
    }
    
    class func set(object : Any? ,forKey key:String) {
        
        let archivedObject = archiveUserInfo(info: object!)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
        
    }
    class func setToken(token: String) {
        Cache.set(object: token, forKey: "token")
        
        
    }

    class func removeObject(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    class func clearToken() {
        Cache.removeObject(key: "token")
        Cache.removeObject(key: "currentUser")
    }
    
}
