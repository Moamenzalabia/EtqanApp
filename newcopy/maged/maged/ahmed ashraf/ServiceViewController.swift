//  ServiceViewController.swift
//  maged
//  Created by Ahmed Ashraf on 2/7/18.
//  Copyright © 2018 maged. All rights reserved.


import UIKit
import Alamofire
class ServiceViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var numOfEmpTextField: UITextField!
    @IBOutlet weak var natPicker: UIPickerView!
    @IBOutlet weak var servicePicker: UIPickerView!
    
    var mainActionsVC: MainActionsVControllerTable?
    
    var nationalities: [Nationality]? = []
    var services: [Service]? = []
    
    var natId:String?
    var serId:String?
    var numEm:String?
    var gender:String?
    
    @IBAction func onClickExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNationalities()
        fetchService()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == natPicker{
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.adjustsFontSizeToFitWidth = true
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = nationalities?[row].name
            return pickerLabel!
        }else{
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.adjustsFontSizeToFitWidth = true
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = services?[row].name
            return pickerLabel!
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == natPicker{
            return (nationalities?.count)!
        }
        return (services?.count)!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == natPicker {
            natId = (nationalities?[row].id)!
        }else{
            serId = (services?[row].id)!
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        if genderSegment.selectedSegmentIndex == 0{
            gender = "male"
        }else{
            gender = "female"
        }
        numEm = numOfEmpTextField.text
        if natId == nil{
            natId = (nationalities?[0].id)!
        }
        if serId == nil{
            serId = (services?[0].id)!
        }
        if numEm == ""{
            numEm = "0"
        }
        
        mainActionsVC?.gender = self.gender!
        mainActionsVC?.natId = self.natId!
        mainActionsVC?.numEm = self.numEm!
        mainActionsVC?.serId = self.serId!
        if mainActionsVC?.isDone != 0{
            mainActionsVC?.isDone += 1
        }
        mainActionsVC?.loadPrice()
        self.dismiss(animated: true, completion: nil)
    }
    func fetchNationalities(){
        let params = ["lang":"en"]
        Alamofire.request("http://ur-business.net/majed/admin/Api/get_nationalities", method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let json = response.result.value as? Dictionary<String, Any>{
                    self.nationalities = [Nationality]()
                    if let message = json["message"] as? [[String : AnyObject]]{
                        for i in 0 ... (message.count-1){
                            if let obj = message[i] as? Dictionary<String, Any>{
                                if let name = obj["nationality_name"] as? String,let id = obj["id"] as? String{
                                    let nat = Nationality()
                                    nat.id = id
                                    nat.name = name
                                    self.nationalities?.append(nat)
                                }
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.natPicker.reloadAllComponents()
                    }
                    
                }
                break
                
            case .failure(_):
                DispatchQueue.main.async {
                    //self.fetchData()
                }
                print(response.result.error!)
                break
                
            }
        }
    }
    func fetchService(){
        let params = ["lang":"en"]
        Alamofire.request("http://ur-business.net/majed/admin/Api/get_services_list", method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let json = response.result.value as? Dictionary<String, Any>{
                    self.services = [Service]()
                    if let message = json["message"] as? [[String : AnyObject]]{
                        for i in 0 ... (message.count-1){
                            if let obj = message[i] as? Dictionary<String, Any>{
                                if let name = obj["name"] as? String,let id = obj["id"] as? String{
                                    let ser = Service()
                                    ser.id = id
                                    ser.name = name
                                    self.services?.append(ser)
                                }
                            }
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.servicePicker.reloadAllComponents()
                    }
                    
                }
                break
                
            case .failure(_):
                DispatchQueue.main.async {
                    //self.fetchData()
                }
                print(response.result.error!)
                break
                
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
