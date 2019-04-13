//  ContentViewController.swift
//  maged
//  Created by Ahmed Ashraf on 2/4/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import Alamofire
import CCMPopup
import SideMenu

var showLanguage: Bool = false

class MainViewController: UITabBarController {
    
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var arabic: UIButton!
    @IBOutlet weak var english: UIButton!
    
    let Check = UIImage(named: "radioSign 1x")
    let UnCheck = UIImage(named: "unCheckRadioSign")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (showLanguage) {
            self.langView.center = self.view.center
            UIView.animate(withDuration: 0.5) {
                self.view.addSubview(self.langView)
                self.langView.transform = CGAffineTransform.init(scaleX:  1.3, y: 1.3)
                self.langView.alpha = 0
                
                UIView.animate(withDuration: 0.4){
                    self.langView.alpha = 1
                    self.langView.transform = CGAffineTransform.identity
                }
            }
        }
        
    }
    
    func getSelectedIndex() {
        if self.selectedIndex != 0 {
            self.selectedIndex = 0
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.langView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.langView.alpha = 0
        self.langView.removeFromSuperview()
        
    }
    
    @IBAction func buttonConfirm(_ sender: Any) {
        
        if Language.currentLanguage == .arabic {
            Constants.Lan = "en"
            Language.swichLanguage()
            UserDefaults.standard.set("en", forKey: "language")
            self.dismiss(animated: true){ () -> Void in
                UIApplication.initWindow()
            }
        } else {
            Constants.Lan = "ar"
            Language.swichLanguage()
            UserDefaults.standard.set("ar", forKey: "language")
            self.dismiss(animated: true){ () -> Void in
                UIApplication.initWindow()
            }
        }
        
    }
    
    @IBAction func ArabicButtonAction(_ sender: UIButton) {
        arabic.setImage(Check, for: .normal)
        english.setImage(UnCheck, for: .normal)
    }
    
    @IBAction func EnglishButtonAction(_ sender: UIButton) {
        english.setImage(Check, for: .normal)
        arabic.setImage(UnCheck, for: .normal)
        
    }
    
    var randomColor: UIColor {
        let colors = [UIColor(hue:0.65, saturation:0.33, brightness:0.82, alpha:1.00),
                      UIColor(hue:0.57, saturation:0.04, brightness:0.89, alpha:1.00),
                      UIColor(hue:0.55, saturation:0.35, brightness:1.00, alpha:1.00),
                      UIColor(hue:0.38, saturation:0.09, brightness:0.84, alpha:1.00)]
        
        let index = Int(arc4random_uniform(UInt32(colors.count)))
        return colors[index]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSideMenu"{
            let sideMenu = SideMenuVC()
            sideMenu.homeref = self
        }
    }
    
}

