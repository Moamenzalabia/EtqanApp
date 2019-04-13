//  ForgetPasswordVC.swift
//  maged
//  Created by MOAMEN on 3/15/19.
//  Copyright © 2019 maged. All rights reserved.

import UIKit
import Alamofire

class ForgetPasswordVC: BaseViewController {

    @IBOutlet weak var emailTextField: RoundTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buForgetPassword(_ sender: Any) {
        if emailTextField.text != "" || isValidEmail(testStr: emailTextField.text!){
        Alamofire.request(URLs.forget_password, method: .post, parameters: ["email": self.emailTextField.text!,"lang":"en"], encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    
                    // the validation for email or password correct and return user data from database
                    guard let jsonData = response.result.value as? Dictionary<String, Any> else { return }
                    guard let status = jsonData["status"] as? Bool else { return }
                    
                    if status == true {
                        self.showAlertsuccess(title: "\(jsonData["message"]!)")
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        self.showAlertWiring(title: "\(jsonData["message"]!)")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlertError(title: "Please check your internet")
                    }
                }
                break
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlertError(title: "Please check your internet")
                }
                break
            }
            
        }
        }else{
            self.showAlertWiring(title: "Invalid Email")
        }
    }
}

extension ForgetPasswordVC{
    
    fileprivate func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
}
