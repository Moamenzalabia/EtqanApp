//  EditProfVC.swift
//  maged
//  Created MOAMEN on 2/28/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import Alamofire

class EditProfVC: BaseViewController {
    
    var effect:UIVisualEffect!
    let Check = UIImage(named: "radioSign 1x")
    let UnCheck = UIImage(named: "unCheckRadioSign")
    var flag:Bool?
    
    @IBOutlet weak var editButtonOutlet: UIButton!
    @IBOutlet weak var VisualEffect: UIVisualEffectView!
    @IBOutlet var updatePasswordView: UIView!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var oldpasswordTextField: UITextField!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet var discoverView: UIView!
    @IBOutlet weak var saveButtonOutlet: RoundedButton!
    
    // update passwordView
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    
    // fetch userdata from userdefualts
    let userId      = String(describing: UserDefaults.standard.object(forKey: "userId") ?? "")
    let userName    = String(describing: UserDefaults.standard.object(forKey: "userName") ?? "")
    let userEmail   = String(describing: UserDefaults.standard.object(forKey: "userEmail") ?? "")
    let userMobile  = String(describing: UserDefaults.standard.object(forKey: "userMobile") ?? "")
    let userAddress = String(describing: UserDefaults.standard.object(forKey: "userAddress") ?? "")
    let userPhone   = String(describing: UserDefaults.standard.object(forKey: "userPhone") ?? "")
        
    var gendertext = String(describing: UserDefaults.standard.object(forKey: "userGender") ?? "")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(self.userId,self.userName,self.userEmail,self.userMobile,self.userAddress,self.userPhone,self.gendertext)
        VisualEffect.isHidden = true
        effect = VisualEffect.effect
        VisualEffect.effect = nil
        
        let flag = UserDefaults.standard.bool(forKey: "Flag")
        if !flag{
            showDiscoverView()
        }
        
        load_Data()
        
        mobileTextField.delegate = self
        phoneTextField.delegate = self
        oldpasswordTextField.delegate = self
        
    }
    
    // MARK: Action
    @IBAction func femaleButtonAction(_ sender: UIButton) {
        self.gendertext = "female"
        femaleButton.setImage(Check, for: .normal)
        maleButton.setImage(UnCheck, for: .normal)
    }
    
    @IBAction func maleButtonAction(_ sender: UIButton) {
        self.gendertext = "male"
        maleButton.setImage(Check, for: .normal)
        femaleButton.setImage(UnCheck, for: .normal)
        
    }
    
    @IBAction func cancelUpdatePasswordButton(_ sender: UIButton) {
        hidePasswordView()
    }
    
    @IBAction func confiremPasswordButton(_ sender: UIButton) {
        if oldPassword.text?.count != 0 || newPassword.text!.count != 0 {
            updatePassword()
        }
        else {
            showAlertWiring(title: "you should complete all info to update Password")
        }
    }
    
    @IBAction func Edit_profile(_ sender: UIButton) {
        
        UsernameTextField.isUserInteractionEnabled = true
        emailTextField.isUserInteractionEnabled = true
        addressTextField.isUserInteractionEnabled = true
        mobileTextField.isUserInteractionEnabled = true
        phoneTextField.isUserInteractionEnabled = true
        oldpasswordTextField.isUserInteractionEnabled = true
        femaleButton.isUserInteractionEnabled = true
        maleButton.isUserInteractionEnabled = true
        saveButtonOutlet.isHidden = false
        anmiteButton()
        
    }
    
    func anmiteButton() {
        
        editButtonOutlet.isUserInteractionEnabled = true
        editButtonOutlet.isEnabled = true
        
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 0.6
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2.7
        animationGroup.repeatCount = 1000
        animationGroup.animations = [pulse1]
        
        editButtonOutlet.layer.add(animationGroup, forKey: "pulse")
        
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        updateProfile()
        editButtonOutlet.layer.removeAnimation(forKey: "pulse")
    }
    
    @IBAction func buToSignUp(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        present(signUpVC!, animated: true, completion: nil)
    }
    
}

extension EditProfVC {
    
    func showUpdatePasswordView(){
        
        self.VisualEffect.isHidden = false
        self.view.addSubview(updatePasswordView)
        updatePasswordView.center = self.view.center
        updatePasswordView.transform = CGAffineTransform.init(scaleX:  1.3, y: 1.3)
        updatePasswordView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.VisualEffect.effect = self.effect
            self.updatePasswordView.alpha = 1
            self.updatePasswordView.transform = CGAffineTransform.identity
        }
    }
    
    func hidePasswordView(){
        
        UIView.animate(withDuration: 0.3) {
            self.updatePasswordView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.updatePasswordView.alpha = 0
            self.VisualEffect.effect = nil
            self.updatePasswordView.removeFromSuperview()
            self.VisualEffect.isHidden = true
        }
    }
    
    func showDiscoverView(){
        
        self.VisualEffect.isHidden = false
        self.view.addSubview(discoverView)
        discoverView.center = self.view.center
        discoverView.transform = CGAffineTransform.init(scaleX:  1.3, y: 1.3)
        discoverView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.VisualEffect.effect = self.effect
            self.discoverView.alpha = 1
            self.discoverView.transform = CGAffineTransform.identity
        }
    }
    
    func hideDiscoverView(){
        
        UIView.animate(withDuration: 0.3) {
            self.discoverView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.discoverView.alpha = 0
            self.VisualEffect.effect = nil
            self.discoverView.removeFromSuperview()
            self.VisualEffect.isHidden = true
        }
    }
    
    func load_Data(){
        
        UsernameTextField.isUserInteractionEnabled      = false
        emailTextField.isUserInteractionEnabled         = false
        addressTextField.isUserInteractionEnabled       = false
        mobileTextField.isUserInteractionEnabled        = false
        phoneTextField.isUserInteractionEnabled         = false
        oldpasswordTextField.isUserInteractionEnabled   = false
        femaleButton.isUserInteractionEnabled           = false
        maleButton.isUserInteractionEnabled             = false
        
        UsernameTextField.text = userName
        emailTextField.text     = userEmail
        addressTextField.text   = userAddress
        mobileTextField.text    = userMobile
        phoneTextField.text!    = userPhone
        
        if gendertext == "male"
        {
            maleButton.setImage(Check, for: .normal)
            femaleButton.setImage(UnCheck, for: .normal)
        }
            
        else
        {
            femaleButton.setImage(Check, for: .normal)
            maleButton.setImage(UnCheck, for: .normal)
        }
        
    }
    
    func updateProfile() {
        
        if (UsernameTextField.text?.count)! < 3 {
            self.showAlertWiring(title: " Please write correct name ")
            return
        }
        
        if !isValidEmail(testStr: emailTextField.text!){
            self.showAlertWiring(title: " Please write correct email")
            return
        }
        
        guard let mobile = mobileTextField.text  else {return}
        if !mobile.hasPrefix("966") || !((mobileTextField.text?.count)! >= 11)  {
            self.showAlertWiring(title: " The mobile number should start with 966 ")
            return
        }
        
        if  (phoneTextField.text?.count)! < 6 {
            self.showAlertWiring(title: " Please write correct phone number")
            return
        }
        
        if (addressTextField.text?.count)! < 3 {
            self.showAlertWiring(title: " Please write correct address ")
            return
        }
        print(UsernameTextField.text!)
        print(emailTextField.text!)
        print(phoneTextField.text!)
        print(mobileTextField.text!)
        print(self.gendertext)
        
        API.Update_profile(lang: "en", gender: self.gendertext, client_id: userId, nameAR: UsernameTextField.text!, nameEN: UsernameTextField.text!, email: emailTextField.text!, phone: phoneTextField.text!, mobile: mobileTextField.text!){(error, suc, status, msg) in
            if error == nil {
                
                if status == true {
                    self.showAlertsuccess(title: msg!)
                    UserDefaults.standard.set(self.gendertext, forKey: "userGender")
                    UserDefaults.standard.set(self.emailTextField.text!, forKey: "userEmail")
                    UserDefaults.standard.set(self.mobileTextField.text!, forKey: "userMobile")
                    UserDefaults.standard.set(self.UsernameTextField.text!, forKey: "userName")
                    UserDefaults.standard.set(self.phoneTextField.text!,forKey:"userPhone")
                }
            }
        }
    }
    
    func updatePassword() {
        
        if (newPassword.text?.count)! <= 5 {
            self.showAlertWiring(title: "The new password must be greater than or equal 6 ")
            return
        }
        
        if (oldPassword.text?.count)! <= 5 {
            self.showAlertWiring(title: "The old password must be greater than or equal 6 ")
            return
        }
        
        API.Update_Password(new_password: newPassword.text!, client_id: userId, old_password: oldPassword.text!) { (error, succ, status, msg) in
            if error == nil {
                if status == true
                {
                    self.showAlertsuccess(title: msg!)
                    self.hidePasswordView()
                    
                }
                else {
                    self.showAlertWiring(title: msg!)
                }
            }
        }
    }
    
    // returen true or false  for email validation
    fileprivate func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
        
    }
    
}

extension EditProfVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == mobileTextField || textField == phoneTextField{
            let allowedCharacterSet = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacterSet.isSuperset(of: characterSet)
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == oldpasswordTextField {
            showUpdatePasswordView()
        }
    }
    
}
