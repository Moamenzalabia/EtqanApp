//
//  Notifction_controller.swift
//  maged
//
//  Created by mohamed on 7/27/18.
//  Copyright © 2018 maged. All rights reserved.
//

import UIKit

class Notifction_controller: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var dataModel: notifction_Model! = notifction_Model(JSON: [:])
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if dataModel.message != nil {
            return dataModel.message!.count ;
        }
        return 0;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Noti"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! notifctio
        cell.msg.text = dataModel.message![indexPath.row].message
        cell.date.text = dataModel.message![indexPath.row].created_at
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "orderDetailsPopUp") as! OrderDetailsVC
        OrderDetailsVC.order_id = dataModel.message![indexPath.row].order_id
        self.present(vc, animated: true, completion: nil)

        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_Data()
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
    }
    override func viewWillAppear(_ animated: Bool) {
        load_Data()
    }
    
}
extension Notifction_controller {
    func  load_Data() {
        let user_id = String(describing: UserDefaults.standard.object(forKey: "id"))
        if user_id != "" {
        
        
        API.Get_notifction(lang: "", client_id:user_id) { (error, suc, model) in
            if error == nil
            {
                self.dataModel = model as! notifction_Model
                self.tableView.reloadData()
            }
            else
            {
                self.showAlertError(title: "الرجاء التحقق من الاتصال بالشبكة")
            }
            
            
        }
        }
        else {
            showAlertWiring(title: "عليك تسجيل الدخول ")
        }
    }
    
}
