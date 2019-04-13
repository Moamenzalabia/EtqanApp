//  ViewController2.swift
//  maged
//  Created by Ahmed Ashraf on 2/4/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import CCMPopup
import SideMenu

class SideMenuVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var homeref: MainViewController!
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        homeref = MainViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        nameLabel.text = String(describing: UserDefaults.standard.object(forKey: "userName") ?? "")
        phoneLabel.text = String(describing: UserDefaults.standard.object(forKey: "userMobile") ?? "")
        addressLabel.text = String(describing: UserDefaults.standard.object(forKey: "userAddress") ?? "")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func buHome(_ sender: Any) {
        self.homeref.getSelectedIndex()
        self.dismiss(animated: true){ () -> Void in
            
            
            //let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            //let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
            //let nav = UINavigationController(rootViewController: mainViewController!)
            //self.present(nav, animated: true, completion: nil)
            
        }
    }
    
    // MARK: - Wallet
    @IBAction func buWallet(_ sender: Any) {
        
    }
    
    @IBAction func buttonOrders(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let orderViewController = storyboard.instantiateViewController(withIdentifier: "OrdersVC") as? OrdersVC
        let nav = UINavigationController(rootViewController: orderViewController!)
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Notifications
    @IBAction func buNotifications(_ sender: Any) {
        //attached using storyboard by segue
    }
    
    // MARK: - Share App
    @IBAction func buShareApp(_ sender: Any) {
        
        if let myWebsite = NSURL(string: "") {
            let objectsToShare = ["", myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Language
    @IBAction func buLanguage(_ sender: Any) {
        
        showLanguage = true
        self.dismiss(animated: true){ () -> Void in }
    }
    
    // MARK: - Log Out
    @IBAction func buLogOut(_ sender: Any) {
        
        UserDefaults.standard.set("", forKey: "userId")
        UserDefaults.standard.set("", forKey: "userGender")
        UserDefaults.standard.set("", forKey: "userEmail")
        UserDefaults.standard.set("", forKey: "userMobile")
        UserDefaults.standard.set("", forKey: "userName")
        UserDefaults.standard.set("", forKey:"userAddress")
        UserDefaults.standard.set("", forKey:"userPhone")
        UserDefaults.standard.set("", forKey: "Y")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        
        self.dismiss(animated: true){ () -> Void in
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            UIApplication.shared.keyWindow?.rootViewController = loginVC
            
        }
        
    }
    
    // MARK: - Rate
    @IBAction func buRate(_ sender: Any) {
        
        rateApp(appId: "id959379869") { success in
            print("RateApp \(success)")
        }
    }
    
}

// MARK: - Extension
extension SideMenuVC{
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
}
    

