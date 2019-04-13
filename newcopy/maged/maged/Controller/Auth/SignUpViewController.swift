//  SignUpViewController.swift
//  maged
//  Created by Ahmed Ashraf on 2/12/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import Alamofire
import SwiftyJSON
import CCMPopup

class SignUpViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var repassTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var conditionButton: UIButton!
    
    var gender:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mobileTextField.delegate = self
        phoneTextField.delegate = self
        conditionArabic()
    }
    
    func conditionArabic() {
        if Language.currentLanguage == .arabic {
            let attributedTitle = NSMutableAttributedString(string: " اوافق علي كل", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black])
            attributedTitle.append(NSAttributedString(string: " "))
            attributedTitle.append(NSAttributedString(string: " الشروط والاحكام ", attributes: [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 255, green: 157, blue: 155)]))
            conditionButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    let check = UIImage(named: "radioSign 1x")
    let UnCheck = UIImage(named: "unCheckRadioSign")
    
    @IBAction func maleButtonAction(_ sender: Any) {
        self.gender = "male"
        maleButton.setImage(check, for: .normal)
        femaleButton.setImage(UnCheck, for: .normal)
    }
    
    @IBAction func femaleButtonAction(_ sender: Any) {
         self.gender = "female"
        femaleButton.setImage(check, for: .normal)
        maleButton.setImage(UnCheck, for: .normal)
    }
    
   
    
    @IBAction func termsAndCondationsButton (_ sender: Any) {
        self.performSegue(withIdentifier: "conditionSegue", sender: nil)
    }
    
    func openPopup(_ segue:UIStoryboardSegue,width:CGFloat = (UIScreen.main.bounds.width * 0.83),height:CGFloat = (UIScreen.main.bounds.height * 0.6),color:UIColor = UIColor.clear){
        let popupSegue = segue as! CCMPopupSegue
        popupSegue.destinationBounds = CGRect(x: -10, y: 40 , width: width , height: height)
        popupSegue.backgroundBlurRadius = 0.0
        popupSegue.dismissableByTouchingBackground = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conditionSegue" {
            openPopup(segue)
        }
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        
        if Language.currentLanguage == .english {
            
            if  (nameTextField.text?.count)! < 3 {
                self.showAlertWiring(title: " Please write correct name ")
                return
            }
            
            if  !isValidEmail(testStr: emailTextField.text!){
                self.showAlertWiring(title: " Please write correct email")
                return
            }
            
            
            if  (mobileTextField.text?.count)! != 10  {
                
                self.showAlertWiring(title: " Please enter correct mobile number ")
                return
                
            }
        
            if  (passTextField.text?.count)!  <= 5  {
                
                self.showAlertWiring(title: " Password must be greater than or equal 6 ")
                return
                
            }
            
            if  repassTextField.text! != passTextField.text! {
                
                self.showAlertWiring(title: " Please confirem your Password again ")
                return
                
            }
            
            if  (phoneTextField.text?.count)! <= 5 {
                 self.showAlertWiring(title: " Please write correct Phone number")
                return
            }
            
            if  (addressTextField.text?.count)! < 3 {
                self.showAlertWiring(title: " Please write correct address ")
                return
            }
            if self.gender == ""{
                self.showAlertWiring(title: " Please select your gender ")
                return
            }
        }else{
            if  (nameTextField.text?.count)! < 3 {
                 self.showAlertWiring(title: "الرجاء كتابة اسم صحيح ")
                 return
            }
            
            if  !isValidEmail(testStr: emailTextField.text!){
                self.showAlertWiring(title: "الرجاء كتابة بريد  الكتروني صحيح ")
                return
            }
            
            
            if  (mobileTextField.text?.count)! != 10  {
                
                self.showAlertWiring(title: "الرجاء كتابة رقم هاتف صحيح ")
                return
                
            }
            
            if  (passTextField.text?.count)!  <= 5  {
                
                self.showAlertWiring(title: " الرقم السري يجب ان يكون اكبر من ٦ ارقام  ")
                return
                
            }
            
            if  repassTextField.text! != passTextField.text! {
                
                self.showAlertWiring(title: "الرجاء التآكد من الرقم السري ")
                return
                
            }
            
            if  (addressTextField.text?.count)! < 3 {
                self.showAlertWiring(title: "الرجاء كتابة رقم عنوان صحيح ")
                return
            }
            
            if  (phoneTextField.text?.count)! <= 5 {
                 self.showAlertWiring(title: "الرجاء كتابة رقم تليفون  صحيح ")
                return
            }
            
           
            if self.gender == ""{
                 self.showAlertWiring(title: "يجب عليك اختيار النوع ")
                return
            }
        }
        
        let parameter = ["email": emailTextField.text!, "password": passTextField.text!, "lang": Constants.Lan, "name": nameTextField.text!,
                         "mobile": mobileTextField.text!, "address": addressTextField.text!, "phone": phoneTextField.text!, "gender": self.gender!]
        
        Alamofire.request("https://etqan.app/admin/Api/registeration", method: .post, parameters: parameter  , encoding: URLEncoding.httpBody, headers: nil).responseJSON { ( response: DataResponse<Any> ) in
            switch(response.result) {
                case .success(_):
                    if response.result.value != nil {
                        var  jsonData = JSON(response.result.value!)
                            if let status = jsonData["status"].bool{
                                if status == true{
                                        DispatchQueue.main.async {
                                            self.login(sender: sender)
                                        }
                                    
                                }else {
                                    let message = jsonData["message"].string
                                    self.showAlertWiring(title: " failed Message: \(message!)")
                                }
                          }
                    }
                break
                
            case .failure(_):
                self.showAlertError(title: "sorry Can't create your account please check your internet or your data ")
                sender.isUserInteractionEnabled = true
                break
            }
        }
    }
    
    func login(sender: UIButton){
        Alamofire.request("https://etqan.app/admin/Api/login", method: .post, parameters: ["email":emailTextField.text!,"password":passTextField.text!,"lang":Constants.Lan], encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil {
                    
                    // the validation for email or password correct and return user data from database
                    guard let jsonData = response.result.value as? Dictionary<String, Any>  else { return }
                    if let userData = jsonData["message"] as? Dictionary<String, Any>  {
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
                                    self.showAlertsuccess(title: "Create your account Successfully")
                                }else{
                                    self.showAlertsuccess(title: "تم عمل حساب بنجاح")
                                }
                                
                                
                                DispatchQueue.main.async {
                                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let homeViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
                                    let nav = UINavigationController(rootViewController: homeViewController!)
                                    self.present(nav, animated: true, completion: nil)

                              }
                         }
                    }
                }else{
                    DispatchQueue.main.async {
                        self.view.endEditing(true)
                        self.showAlertError(title: "Some error happend when fetch your data ")
                        sender.isUserInteractionEnabled = true
                    }
                }
                break
                
            case .failure(_):
                DispatchQueue.main.async {
                    self.showAlertError(title: "Please check your internet connection")
                    self.view.endEditing(true)
                    sender.isUserInteractionEnabled = true
                }
                break
                
            }
        }
    }
    
    // go to login vc
    @IBAction func logInButtonAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let logInVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        self.present(logInVC!, animated: true, completion: nil)
    }
    
    // returen true or false  for email validation
   fileprivate func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
}

// this to allow mobiletextfield and phonetextfield accept only number input
extension SignUpViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let allowedCharacterSet = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacterSet.isSuperset(of: characterSet)
        
    }
}
