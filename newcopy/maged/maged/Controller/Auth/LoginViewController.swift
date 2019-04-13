//  LoginViewController.swift
//  maged
//  Created by Ahmed Ashraf on 2/11/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import Alamofire

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passTextField.delegate = self
        emailTextField.delegate = self
        
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        
        if Language.currentLanguage == .english {
            
            if !isValidEmail(testStr: emailTextField.text!){
                errorMessage.alpha = 1
                errorMessage.text = " Error in your email, please try again"
                return
            }
            
            if  passTextField.text!.count <= 5  {
                errorMessage.alpha = 1
                errorMessage.text = " Password must be greater than or equal 6 "
                return
            }
        }else{
            if !isValidEmail(testStr: emailTextField.text!){
                errorMessage.alpha = 1
                errorMessage.text = "خطآ في حسابك الشخصي، حاول مره اخري "
                return
            }
            
            if  passTextField.text!.count <= 5  {
                errorMessage.alpha = 1
                errorMessage.text = " الرقم السري يجب ان يكون اكبر من ٦ ارقام  "
                return
            }
        }
        
        sender.isUserInteractionEnabled = false
        loadingIndicatorView.alpha = 1
        errorMessage.alpha = 0
        
        guard  let usereEmail = emailTextField.text else { return }
        guard  let userPassword = passTextField.text else { return}
        
        Alamofire.request(URLs.login_User, method: .post, parameters: ["email": usereEmail,"password": userPassword,"lang":"en"], encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
                switch(response.result) {
                     case .success(_):
                        if response.result.value != nil {
                          
                            // the validation for email or password correct and return user data from database
                            guard let jsonData = response.result.value as? Dictionary<String, Any> else { return }
                            guard let status = jsonData["status"] as? Bool else { return }
                            
                            if status == true {
                                
                                if let userData = jsonData["message"] as? Dictionary <String, Any> {
                                    print("user data >>>>>>>>>>>", userData)
                                    if let userId         = userData["id"] as? String
                                        ,let userGender   = userData["gender"] as? String
                                        ,let userEmail    = userData["email"] as? String
                                        ,let userMobile   = userData["mobile"] as? String
                                        ,let userName     = userData["nameAR"] as? String
                                        ,let userAddress  = userData["addressAR"] as? String
                                        ,let userPhone    = userData["phone"] as? String {
                                        
                                        UserDefaults.standard.set(userId, forKey: "userId")
                                        UserDefaults.standard.set(userGender, forKey: "userGender")
                                        UserDefaults.standard.set(userEmail, forKey: "userEmail")
                                        UserDefaults.standard.set(userMobile, forKey: "userMobile")
                                        UserDefaults.standard.set(userName, forKey: "userName")
                                        UserDefaults.standard.set(userAddress,forKey:"userAddress")
                                        UserDefaults.standard.set(userPhone,forKey:"userPhone")
                                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                                        UserDefaults.standard.set(true, forKey:"Flag")
                                        
                                        if Language.currentLanguage == .english {
                                                self.showAlertsuccess(title: "Login Successfully")
                                        }else{
                                            self.showAlertsuccess(title: "تم تسجيل الدخول بنجاح")
                                        }
                                        DispatchQueue.main.async {
                                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
                                            let nav = UINavigationController(rootViewController: mainViewController!)
                                            self.present(nav, animated: true, completion: nil)
                                        }
                                    }
                                }
                             }else{
                                
                                      DispatchQueue.main.async {
                                        // the validation for email or password correct but not exist in database and (status) is (false)
                                            self.loadingIndicatorView.alpha = 0
                                            self.errorMessage.alpha = 1
                                            self.errorMessage.text = "Check your email or password again!"
                                            sender.isUserInteractionEnabled = true
                                        
                                        }
                                    }
                        } else {
                                DispatchQueue.main.async {
                                    // the validation for email or password correct but not exist in database and (status) is (false)
                                    self.loadingIndicatorView.alpha = 0
                                    self.errorMessage.alpha = 1
                                    self.errorMessage.text = "Check your email or password again!"
                                    sender.isUserInteractionEnabled = true
                            }
                        }
                             break
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.showAlertError(title: "Please check your internet connection")
                            self.loadingIndicatorView.alpha = 0
                            self.view.endEditing(true)
                            sender.isUserInteractionEnabled = true
                        }
                         break
                 }
            }
        }
    
    @IBAction func forgetPassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordVC")
        self.present(initialViewController, animated: true, completion: nil)
    }
    
    // go to signup vc
    @IBAction func signUPButtonAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.present(signUpVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func DicoverAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "DiscoverVC") as? DiscoverVC
        self.present(signUpVC!, animated: true, completion: nil)
        
    }
    
    // email validation function
    func isValidEmail(testStr:String) -> Bool {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }

}

// text field delegate extension to handel login button color's change
extension LoginViewController: UITextFieldDelegate{
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if passTextField.text!.count == 0 || emailTextField.text!.count == 0{
            errorMessage.alpha = 0
        }
        emailTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if passTextField.text!.count == 0 || emailTextField.text!.count == 0 {
            errorMessage.alpha = 0
            
        }
        emailTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        passTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        
    }
    
    //Mark: to ask user to enter all text field before signup to app
    @objc func handleTextInputChange() {
        
        let isFormVaild = emailTextField.text!.count > 0  && passTextField.text!.count > 0
        
        if isFormVaild {
            loginButtonOutlet.backgroundColor = UIColor.rgb(red: 238, green: 57, blue: 64)
        } else {
            loginButtonOutlet.backgroundColor = UIColor.rgb(red: 238, green: 140, blue: 145)
        }
        
    }
    
}
