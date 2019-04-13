//  OrderResultVC.swift
//  maged
//  Created by Ahmed Ashraf on 2/19/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import Alamofire

class Make_order: BaseViewController {
    
    // MARK: Init Paramters
    let id = UserDefaults.standard.string(forKey: "userId")
    static  var lat = ""
    static  var lang = ""
    static  var Address = ""
    var Choosen_Days                = [String]()
    var Choosen_gender              = "female"
    var Choosen_employees_num       = "1"
    var Choosen_months_number       = ""
    var Choosen_start_time          = ""
    var Choosen_duration            = 2
    var Choosen_service_id          = ""
    
    @IBOutlet weak var datePickerTxt        : UITextField!
    @IBOutlet weak var timePickerTxt        : UITextField!

    var currentDurion    = 2
    var currentEmployeeNumber = 1
    var time = ["01:00 AM","02:00 AM","03:00 AM","04:00 AM","05:00 AM","06:00 AM","07:00 AM","08:00AM","09:00 AM","10:00 AM","11:00 AM","12:00 PM", "01:00 PM","02:00 PM","03:00 PM","04:00 PM","05:00 PM","06:00 PM","07:00 PM","08:00 PM","09:00 PM","10:00 PM","11:00 PM","12:00 AM"]
    var Service          = [String]()
    var Subscription     = ["1 month","2 month","3 month","4 month","5 month","6 month"]
    
    var sat_satus        = 0
    var sun_satus        = 0
    var mon_satus        = 0
    var tus_satus        = 0
    var wen_satus        = 0
    var sat_             = ""
    var sun_             = ""
    var mon_             = ""
    var tus_             = ""
    var wen_             = ""

    let datePicker = UIDatePicker()
    var effect:UIVisualEffect!
    
    @IBOutlet weak var loctione_Edittext    : UITextField!
    @IBOutlet weak var service_Edittext     : UITextField!
    @IBOutlet weak var Subscription_Edittext: UITextField!
    @IBOutlet weak var VisualEffect         : UIVisualEffectView!
    @IBOutlet var mapView                   : UIView!
    @IBOutlet var submitView                : UIView!
    @IBOutlet weak var   Price_label        : UILabel!
    @IBOutlet weak var   number_employee    : UILabel!
    @IBOutlet weak var   Duratioin_text     : UILabel!
    @IBOutlet weak var   S_Duration         : UILabel!
    @IBOutlet weak var   S_Date             : UILabel!
    @IBOutlet weak var   S_Time             : UILabel!
    @IBOutlet weak var   S_Sat              : UILabel!
    @IBOutlet weak var   S_Sun              : UILabel!
    @IBOutlet weak var   S_Mon              : UILabel!
    @IBOutlet weak var   S_Tus              : UILabel!
    @IBOutlet weak var   S_Wen              : UILabel!
    @IBOutlet weak var   S_Sub              : UILabel!
    @IBOutlet weak var   S_Price            : UILabel!
    @IBOutlet weak var time_piker           : UIPickerView!
    @IBOutlet weak var Service_piker        : UIPickerView!
    @IBOutlet weak var Subscription_piker   : UIPickerView!
    @IBOutlet weak var sat: UIButton!
    @IBOutlet weak var sun: UIButton!
    @IBOutlet weak var mon: UIButton!
    @IBOutlet weak var tus: UIButton!
    @IBOutlet weak var wen: UIButton!
    @IBOutlet weak var decreaseEmployee: RoundedButton!
    @IBOutlet weak var increaseEmployee: RoundedButton!
    @IBOutlet weak var decreaseDuration: RoundedButton!
    @IBOutlet weak var increaseDuration: RoundedButton!
    @IBOutlet weak var chooseDate: UITextField!
    @IBOutlet weak var startTime: UITextField!
    @IBOutlet weak var cash: CustomEditField!
    @IBOutlet weak var submit: RoundedButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var maleButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disabeledActions()
        loctione_Edittext.text = Make_order.Address
        VisualEffect.isHidden = true
        effect = VisualEffect.effect
        VisualEffect.effect = nil
        self.Subscription_piker.setValue(UIColor.white, forKeyPath: "textColor")
        loadData()
        createDatePicker()
        if Language.currentLanguage == .english {
            showAlertWiring(title: "Please selecte your service first")
        }else{
            self.showAlertWiring(title: "الرجاء اختيار نوع الخدمه اولآ ")
        }
        print(">>>>>>>>>>>>>>>>>>>>>>>>", id!)
    }
    
    let check = UIImage(named: "radioSign 1x")
    let UnCheck = UIImage(named: "unCheckRadioSign")
    
    @IBAction func maleButtonAction(_ sender: Any) {
        Choosen_gender = "male"
        maleButton.setImage(check, for: .normal)
        femaleButton.setImage(UnCheck, for: .normal)
    }
    
    @IBAction func femaleButtonAction(_ sender: Any) {
        Choosen_gender = "female"
        femaleButton.setImage(check, for: .normal)
        maleButton.setImage(UnCheck, for: .normal)
    }
    
    
    func disabeledActions(){

        Subscription_Edittext.isUserInteractionEnabled = false
        sat.isUserInteractionEnabled = false
        sun.isUserInteractionEnabled = false
        mon.isUserInteractionEnabled = false
        tus.isUserInteractionEnabled = false
        wen.isUserInteractionEnabled = false
        decreaseEmployee.isUserInteractionEnabled = false
        increaseEmployee.isUserInteractionEnabled = false
        decreaseDuration.isUserInteractionEnabled = false
        increaseDuration.isUserInteractionEnabled = false
        chooseDate.isUserInteractionEnabled = false
        cash.isUserInteractionEnabled = false
        startTime.isUserInteractionEnabled = false
        maleButton.isUserInteractionEnabled = false
        femaleButton.isUserInteractionEnabled = false
        submit.isUserInteractionEnabled = false

    }
    
    func enableActions(){
        Subscription_Edittext.isUserInteractionEnabled = true
        sat.isUserInteractionEnabled = true
        sun.isUserInteractionEnabled = true
        mon.isUserInteractionEnabled = true
        tus.isUserInteractionEnabled = true
        wen.isUserInteractionEnabled = true
        decreaseEmployee.isUserInteractionEnabled = true
        increaseEmployee.isUserInteractionEnabled = true
        decreaseDuration.isUserInteractionEnabled = true
        increaseDuration.isUserInteractionEnabled = true
        chooseDate.isUserInteractionEnabled = true
        cash.isUserInteractionEnabled = true
        startTime.isUserInteractionEnabled = true
        maleButton.isUserInteractionEnabled = true
        femaleButton.isUserInteractionEnabled = true
        submit.isUserInteractionEnabled = true
        
    }
    
    @IBAction func increment_employee(_ sender: Any) {
        
        if currentEmployeeNumber == 5 {
           if Language.currentLanguage == .english {
                showAlertWiring(title: "Maximum employee number 5")
           }else{
                 showAlertWiring(title: "الحد الاقصي للموظفين ٥")
            }
            
            if check_data() == true {getPrice()}
            return
        } else{
            currentEmployeeNumber += 1
            number_employee.text = "\(currentEmployeeNumber)"
            Choosen_employees_num = "\(currentEmployeeNumber)"
            if check_data() == true {getPrice()}
            return
        }
        
    }
    
    @IBAction func decrement_employee(_ sender: Any) {
        if currentEmployeeNumber == 1 {
            if Language.currentLanguage == .english {
                showAlertWiring(title: "Minimum employee number 1")
            }else{
                showAlertWiring(title: "الحد الادني للموظفين ١ ")
            }
        
            if check_data() == true {getPrice()}
            return
        } else{
            currentEmployeeNumber -= 1
            number_employee.text = "\(currentEmployeeNumber)"
            Choosen_employees_num = "\(currentEmployeeNumber)"
            if check_data() == true {getPrice()}
            return
        }
        
    }
    
    @IBAction func increment_Duratioin(_ sender: Any) {
       
        if currentDurion == 8 {
            
            if Language.currentLanguage == .english {
                 showAlertWiring(title: "Maximum duratioin number 8")
            }else{
                showAlertWiring(title: " الحد الاقصي للمدة ٨ايام")
            }
           
            if check_data() == true {getPrice()}
            return
        } else{
            currentDurion += 2
            Duratioin_text.text! = "\(currentDurion)"
            Choosen_duration = currentDurion
            if check_data() ==  true {getPrice()}
            return
        }
        
    }
    
    @IBAction func decrement_Duratioin(_ sender: Any) {
        if currentDurion == 2 {
           if Language.currentLanguage == .english {
                showAlertWiring(title: "Minimum duratioin number 2")
            }else{
                showAlertWiring(title: " الحد الادني للمدة يومان")
            }
           
            if check_data() ==  true {getPrice()}
            return
        } else{
            currentDurion -= 2
            Duratioin_text.text! = "\(currentDurion)"
            Choosen_duration = currentDurion
            if check_data() ==  true {getPrice()}
            return
        }
        
    }

    @IBAction func sat(_ sender: UIButton) {
        if sat_satus == 0{
            sat_satus = 1
            Choosen_Days.append("Saturday")
            sat_ = "Saturday"
          print(Choosen_Days)
            sat.setTitleColor(.red, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
        return
        }
        if sat_satus == 1{
            sat_satus = 0
            sat_ = ""
            if let index = Choosen_Days.index(of: "Saturday") {
                Choosen_Days.remove(at: index)
            }
            print(Choosen_Days)
            sat.setTitleColor(.black, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
    }
    
    @IBAction func sun(_ sender: UIButton) {
        if sun_satus == 0{
            sun_satus = 1
            sun_ = "Sunday"
            Choosen_Days.append("Sunday")

           print(Choosen_Days)
            sun.setTitleColor(.red, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
        if sun_satus == 1{
            sun_satus = 0
            if let index = Choosen_Days.index(of: "Sunday") {
                Choosen_Days.remove(at: index)
            }
            print(Choosen_Days)
            sun_ = ""

            sun.setTitleColor(.black, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
    }
    
    @IBAction func mon(_ sender: UIButton) {
        if mon_satus == 0{
            mon_satus = 1
            mon_ = "Monday"

            Choosen_Days.append("Monday")
            print(Choosen_Days)
            mon.setTitleColor(.red, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
        if mon_satus == 1{
            if let index = Choosen_Days.index(of: "Monday") {
                Choosen_Days.remove(at: index)
            }
            mon_satus = 0
            mon_ = ""

            print(Choosen_Days)
            mon.setTitleColor(.black, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
    }
    
    @IBAction func tus(_ sender: UIButton) {
        if tus_satus == 0{
            tus_satus = 1
            tus_ = "Tuesday"

            Choosen_Days.append("Tuesday")
            print(Choosen_Days)
            tus.setTitleColor(.red, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
        if tus_satus == 1{
            tus_satus = 0
            tus_ = ""
            if let index = Choosen_Days.index(of: "Tuesday") {
                Choosen_Days.remove(at: index)
            }
            print(Choosen_Days)
            tus.setTitleColor(.black, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
    }
    
    @IBAction func Wen(_ sender: UIButton) {
        if wen_satus == 0{
            wen_satus = 1
            wen_ = "Wednesday"
            print(Choosen_Days)
            Choosen_Days.append("Wednesday")
            wen.setTitleColor(.red, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
        }
        if wen_satus == 1{
            if let index = Choosen_Days.index(of: "Wednesday") {
                Choosen_Days.remove(at: index)
            }
            wen_satus = 0
            wen_ = ""
            print(Choosen_Days)
            wen.setTitleColor(.black, for: UIControlState.normal)
            if check_data() ==  true {getPrice()}
            return
     
        }
    }
    @IBAction func Submit_btn(_ sender: UIButton) {
        if SubmitCheck()  == true {
            
              S_Duration.text = "\(Choosen_duration)"
              S_Date.text = datePickerTxt.text!
              S_Time.text = timePickerTxt.text!
              S_Sat.text = sat_
              S_Sun.text = sun_
              S_Mon.text = mon_
              S_Tus.text = tus_
              S_Wen.text = wen_
              S_Sub.text = "\(Choosen_months_number)"
              S_Price.text = Price_label.text!
            Show_Submit_View()
        }
       
    }


    @IBAction func Confirm(_ sender: UIButton) {
        if UserDefaults.standard.string(forKey: "userId") == nil {
            if Language.currentLanguage == .english {
                showAlertWiring(title: "Please sign up to make order")
            }else{
                 showAlertWiring(title: "يتطلب ذلك عمل حساب آولا")
            }
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let signUpVC = storyBoard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
            present(signUpVC!, animated: true, completion: nil)
        }else{
            MackOrder()
        }
    }
    
    @IBAction func disable(_ sender: UIButton) {
            Hide_Submit_View()
    }
    
}

extension Make_order:UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var CountRows = time.count
        if pickerView  == Service_piker{
            CountRows = Service.count
        }
         if pickerView  == Subscription_piker{
            CountRows = Subscription.count
        }
        return CountRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView  == Subscription_piker{
            let titleRow = Subscription[row]
            return titleRow
        }
        else if pickerView  == Service_piker{
            let titleRow = Service[row]
            return titleRow
        }
        else if pickerView  == time_piker{
            let titleRow = time[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView  == Subscription_piker{
            self.Subscription_Edittext.text = Subscription[row]
            Choosen_months_number = "\(row + 1)"
            self.Subscription_piker.isHidden = true
            Hide_Map_View()
            self.Subscription_Edittext.resignFirstResponder()
            if check_data() ==  true {getPrice()}
            
        }
        else if pickerView  == Service_piker{
            self.service_Edittext.text = self.Service[row]
            Choosen_service_id = "\(row)"
            enableActions()
            self.Service_piker.isHidden = true
            Hide_Map_View()
            self.service_Edittext.resignFirstResponder()
            if check_data() ==  true {getPrice()}
            
            
        }
        else if pickerView  == time_piker{
            self.timePickerTxt.text = self.time[row]
            Choosen_start_time = "\(row + 1)"
            self.time_piker.isHidden = true
            Hide_Map_View()
            self.timePickerTxt.resignFirstResponder()
            if check_data() ==  true {getPrice()}
            
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == self.service_Edittext){
            self.Service_piker.isHidden = true
            Hide_Map_View()
        }
        else if (textField == self.Subscription_Edittext){
            self.Subscription_piker.isHidden = true
            Hide_Map_View()
            
        }
        else if (textField == self.timePickerTxt){
            
            self.time_piker.isHidden = true
            Hide_Map_View()
            
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if (textField == self.service_Edittext){
            Show_map_View()
            self.Service_piker.reloadAllComponents();
            self.Service_piker.isHidden = false
            self.time_piker.isHidden = true
            self.Subscription_piker.isHidden = true
            // self.service_Edittext.resignFirstResponder()
            
        } else if (textField == self.Subscription_Edittext){
            Show_map_View()
            self.Subscription_piker.reloadAllComponents();
            self.Service_piker.isHidden = true
            self.time_piker.isHidden = true
            self.Subscription_piker.isHidden = false
          //  self.Subscription_Edittext.resignFirstResponder()

        }

        else if (textField == self.timePickerTxt){
            Show_map_View()
            self.time_piker.reloadAllComponents();
            self.Service_piker.isHidden = true
            self.time_piker.isHidden = false
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            self.Subscription_piker.isHidden = true
            
        }
        
        
    }
    
}

extension Make_order {
    
    func MackOrder() {
 
        API.make_subscribe(
        lang: "en",
        gender: Choosen_gender,
        service_id: "\(Int(Choosen_service_id)! + 1)",
        hours_number: Choosen_months_number,
        days: Choosen_Days,
        duration: Choosen_duration,
        client_id: id!,
        latitude: Make_order.lat,
        longitude: Make_order.lang,
        time_from: Choosen_start_time,
        date: datePickerTxt.text!,
        team_number: Choosen_employees_num)
        { (error, suc, status, msg) in
            if error == nil  {
                if status == true
                {
                    self.showAlertsuccess(title: msg!)
                    guard let window = UIApplication.shared.keyWindow else { return }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    var Vc: UIViewController
                    Vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                    let nav = UINavigationController(rootViewController: Vc)
                    window.rootViewController = nav
                    UIView.transition(with: window, duration: 0.6, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    
                }
                else {
                    self.showAlertWiring(title: msg!)
                    guard let window = UIApplication.shared.keyWindow else { return }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    var Vc: UIViewController
                    Vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                    let nav = UINavigationController(rootViewController: Vc)
                    window.rootViewController = nav
                    UIView.transition(with: window, duration: 0.6, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    
                }
            }else{
                guard let window = UIApplication.shared.keyWindow else { return }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                var Vc: UIViewController
                Vc = storyboard.instantiateViewController(withIdentifier: "MainViewController")
                let nav = UINavigationController(rootViewController: Vc)
                window.rootViewController = nav
                UIView.transition(with: window, duration: 0.6, options: .transitionFlipFromTop, animations: nil, completion: nil)
                print("order error>>>>>>>>>>>>>>>>>>>........" ,(error?.localizedDescription)!)
                if Language.currentLanguage == .english {
                    self.showAlertError(title: "Please check your internet connection")
                }else{
                     self.showAlertWiring(title: "الرجاء التحقق من الاتصال بالشبكة ")
                }
                
            }
        }
    }
    
    
    // ALL Methods Used In this VC
    func SubmitCheck() -> Bool {
        
         if Language.currentLanguage == .english {
                if       Make_order.Address    == "" {showAlertWiring(title: "Please enter your address")          ; return false}
                else if  Make_order.lat        == "" {showAlertWiring(title: "Please enter your address")       ; return false}
                else if  Make_order.lang       == "" {showAlertWiring(title: "Please enter your address")       ; return false}
                else if  Choosen_months_number     == "" {showAlertWiring(title:  "Please enter duration of subscription")        ; return false}
                else if  Choosen_service_id       == "" {showAlertWiring(title:  "Please enter service type")         ; return false}
                else if  datePickerTxt.text!      == "" {showAlertWiring(title: "Please enter start date")        ; return false}
                else if  timePickerTxt.text!      == "" {showAlertWiring(title: "Please enter start time")          ; return false}
                else if  id                       == "" {showAlertWiring(title: "Please make an account or login")          ; return false}
                else if  Choosen_Days.count       == 0  {showAlertWiring(title: "Please choose at least one day") ; return false}
                else if  Choosen_employees_num    == "" { return false}
                else if  Choosen_duration         == 0 { return false}
                else if  Choosen_gender           == "" { return false}
                else  {return true}
         }else{
            
                if       Make_order.Address    == "" {showAlertWiring(title: "يجب ان تختار عنوان لك")          ; return false}
                else if  Make_order.lat        == "" {showAlertWiring(title: "يجب عليك اختيار عنوان لك")       ; return false}
                else if  Make_order.lang       == "" {showAlertWiring(title: "يجب عليك اختيار عنوان لك")       ; return false}
                else if  Choosen_months_number     == "" {showAlertWiring(title: "يجب ان تحدد مدة الاشتراك")        ; return false}
                else if  Choosen_service_id       == "" {showAlertWiring(title: "يجب ان تحدد نوع الخدمة")         ; return false}
                else if  datePickerTxt.text!      == "" {showAlertWiring(title: "يجب ان تحدد تاريخ البدء")        ; return false}
                else if  timePickerTxt.text!      == "" {showAlertWiring(title: "يجب ان تحدد وقت البدء")          ; return false}
                else if  id                       == "" {showAlertWiring(title: "يجب عليك تسجيل الدخول")          ; return false}
                else if  Choosen_Days.count       == 0  {showAlertWiring(title: "يجب ان تختار على الاقل يوم واحد") ; return false}
                else if  Choosen_employees_num    == "" { return false}
                else if  Choosen_duration         == 0 { return false}
                else if  Choosen_gender           == "" { return false}
                else  {return true}
            
        }
    }
    
    func Show_Submit_View(){
        
        self.VisualEffect.isHidden = false
        self.view.addSubview(submitView)
        submitView.center = self.view.center
        submitView.transform = CGAffineTransform.init(scaleX:  1.3, y: 1.3)
        submitView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.VisualEffect.effect = self.effect
            self.submitView.alpha = 1
            self.submitView.transform = CGAffineTransform.identity
        }
        
    }
    
    func Hide_Submit_View()
    {
        UIView.animate(withDuration: 0.3) {
            self.submitView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.submitView.alpha = 0
            self.VisualEffect.effect = nil
            self.submitView.removeFromSuperview()
            self.VisualEffect.isHidden = true
            
        }
    }
    func Show_map_View(){
        self.VisualEffect.isHidden = false
        self.view.addSubview(mapView)
        mapView.center = self.view.center
        mapView.transform = CGAffineTransform.init(scaleX:  1.3, y: 1.3)
        mapView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.VisualEffect.effect = self.effect
            self.mapView.alpha = 1
            self.mapView.transform = CGAffineTransform.identity
        }
    }
    
    func Hide_Map_View()
    {
        UIView.animate(withDuration: 0.3) {
            self.mapView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.mapView.alpha = 0
            self.VisualEffect.effect = nil
            self.mapView.removeFromSuperview()
            self.VisualEffect.isHidden = true
            
        }
    }
    
    func createDatePicker() {
        
        // format for picker
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = UIColor(red: 255/255, green: 130/255, blue: 134/255, alpha: 1)
        datePicker.setValue(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), forKeyPath: "textColor")
        datePicker.setValue(1, forKeyPath: "alpha")
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        toolbar.tintColor = UIColor(red: 255/255, green: 130/255, blue: 134/255, alpha: 1)
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(date_donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        
        // assigning date picker to text field
        datePickerTxt.inputView = datePicker
        
        
    }

    
    
    @objc func date_donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        datePickerTxt.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func loadData(){
        API.List_service(lang:"en"){ (error: Error?, success: Bool,No3_list: [String]?)  in
            if success
            {
                guard let mob_list = No3_list else { return }
                print(No3_list)
                self.Service = mob_list
            } else
            {
                
            }
        }
        
    }
    
    func  getPrice(){
        
        API.Get_price(
            lang: "en",
            gender: Choosen_gender,
            service_id: "\(Int(Choosen_service_id)! + 1)",
            employees_num: Choosen_employees_num,
            hours_number: Choosen_months_number,
            days: Choosen_Days,
            duration: Choosen_duration) { (error,succ, status, price) in

                if error == nil {
                    if status == true
                    {
                        print("\(price!)")
                        self.Price_label.text = "\(price!)"
                    }
                }
        }
    }
    
    func check_data() -> Bool {
        if       Choosen_Days.count       == 0  { return false}
        else if  Choosen_gender           == "" { return false}
        else if  Choosen_employees_num    == "" { return false}
        else if  Choosen_months_number     == "" { return false}
        else if  Choosen_duration         == 0 { return false}
        else if  Choosen_service_id       == "" { return false}
        else  {return true}
        
    }
    
}
