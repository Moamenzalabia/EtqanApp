//
//  VisitDetailsVC.swift
//  maged
//
//  Created by Ahmed Ashraf on 2/12/18.
//  Copyright © 2018 maged. All rights reserved.
//

import UIKit

class VisitDetailsVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var durationPicker: UIPickerView!
    var durations: [String]? = []
    var duration: String?
    
    var mainActionsVC: MainActionsVControllerTable?
    
    var date: String?
    var time: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in (1..<11){
            durations?.append("\(i) hours")
        }
    }
    @IBAction func onExitTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return durations?[row]
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (durations?.count)!
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        duration = String(row+1)
    }
    @IBAction func doneTapped(_ sender: UIButton) {
        
        datePicker.datePickerMode = UIDatePickerMode.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = dateFormatter.string(from: datePicker.date)
        
        var dateArr = date!.components(separatedBy: " ")
        date = dateArr[0]
        time = dateArr[1]
        
        mainActionsVC?.date = self.date!
        mainActionsVC?.time = self.time!
        mainActionsVC?.duration = String(durationPicker.selectedRow(inComponent: 0)+1)
        if mainActionsVC?.isDone != 0{
            mainActionsVC?.isDone += 1
        }
        mainActionsVC?.loadPrice()
        self.dismiss(animated: true, completion: nil)
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
