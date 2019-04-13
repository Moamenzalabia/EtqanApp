//  OrdersVC.swift
//  maged
//  Created by Ahmed Ashraf on 2/19/18.
//  Copyright © 2018 maged. All rights reserved.

import UIKit
import Alamofire
class OrdersVC: BaseViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var orderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var dataModel: Orders_Model! = Orders_Model(JSON: [:])
    
    func numberOfSections(in tableView: UITableView) -> Int{
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if dataModel.Data != nil {
            return dataModel.Data!.count ;
        }
        
        return 0;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "orderCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OrderCell
        cell.color.backgroundColor = getRandomColor()
        cell.setModel(model: dataModel.Data![indexPath.row])
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "orderDetailsPopUp") as? OrderDetailsVC{
            OrderDetailsVC.client_latitude   = Double("\(dataModel.Data![indexPath.row].client_latitude!)")!
            OrderDetailsVC.client_longitude  = Double("\(dataModel.Data![indexPath.row].client_longitude!)")!
            OrderDetailsVC.suber_lat         = Double("\(dataModel.Data![indexPath.row].supervisor_latitude!)")!
            OrderDetailsVC.suber_long        = Double("\(dataModel.Data![indexPath.row].supervisor_longitude!)")!

            self.present(vc, animated: true, completion: nil)
            vc.dateLbl.text   = dataModel.Data![indexPath.row].date
            vc.statusLbl.text = dataModel.Data![indexPath.row].status
            vc.timeLbl.text   = dataModel.Data![indexPath.row].to

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //showOrderView()
        if UserDefaults.standard.string(forKey: "userId") == nil {
            self.showOrderView()
            return
        }
        DispatchQueue.main.async {
            self.load_Data()
        }
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        tableView.contentInset = .zero
        
    }
    
    @IBAction func buMakeOrder(_ sender: Any) {
        
        let makeOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "Make_order") as! Make_order
        self.navigationController?.pushViewController(makeOrderVC, animated: true)
        
    }
    
    func showOrderView(){
        self.tableView.isHidden = true
        self.view.addSubview(orderView)
        orderView.center = self.view.center
        orderView.transform = CGAffineTransform.init(scaleX:  1.3, y: 1.3)
        orderView.alpha = 0

        UIView.animate(withDuration: 0.4){
            self.orderView.alpha = 1
            self.orderView.transform = CGAffineTransform.identity
        }
    }

}

extension OrdersVC {
    func  load_Data() {

        guard let user_id = UserDefaults.standard.string(forKey: "userId") else {return}
        print("userrrrrrrr iddddd: ",user_id)

        API.My_itmes(lang: "en", client_id:user_id) { (error, suc, model) in
            if error == nil
            {
                
                print("pppppp",UserDefaults.standard.string(forKey: "Y")!)
                if UserDefaults.standard.string(forKey: "Y")! == "0"{
                    self.showOrderView()
                }else{
                    self.dataModel = model as! Orders_Model
                    self.tableView.reloadData()
                }
                
            }else{
                print("error>>>>>>>>>>>>>>>>>>>>>>>...******", error!.localizedDescription)
            }
            
        }
    
    }
    
}
