//
//  MainActionsVControllerTableViewController.swift
//  maged
//
//  Created by Ahmed Ashraf on 2/7/18.
//  Copyright © 2018 maged. All rights reserved.
//

import UIKit
import GooglePlaces
import Alamofire
class MainActionsVControllerTable: UITableViewController {
    
    @IBOutlet weak var priceLbl: UILabel!
    var vc:HomeViewController?
    
    var isDone = -2
    
    var date: String?
    var time: String?
    
    var natId: String?
    var serId: String?
    var numEm: String?
    var gender: String?
    var duration: String?
    
    var latitude: String?
    var longitude: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        if indexPath.row == 1 {
//
//            if let vc = storyboard?.instantiateViewController(withIdentifier: "myPopupView") as? ServiceViewController{
//
//                vc.mainActionsVC = self
//                self.present(vc, animated: true, completion: nil)
//            }
//        }else
            if indexPath.row == 0
            {
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = vc
            let filter = GMSAutocompleteFilter()
            filter.type = .establishment
            filter.country = "EG"
            autocompleteController.autocompleteFilter = filter
            present(autocompleteController, animated: true, completion: nil)
            }
//            else if indexPath.row == 2 {
//            if let vc = storyboard?.instantiateViewController(withIdentifier: "visitDetailsPop") as? VisitDetailsVC{
//                vc.mainActionsVC = self
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    @IBAction func makeOrderTapped(_ sender: UIButton) {

   
            
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Make_order") as! Make_order
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
        
       
    }
    func makeOrder(){
        
    }
    func loadPrice(){
        if isDone == 0 {
            let params = ["lang":Constants.Lan,"nationality_id":natId!,"gender":gender!,"service_id":serId!,"employees_num":numEm!]
            Alamofire.request("http://ur-business.net/majed/admin/Api/get_price", method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
                
                switch(response.result) {
                case .success(_):
                    if response.result.value != nil {
                        let s = String(describing: response.result.value!)
                        print(s)
                        if let json = response.result.value as? Dictionary<String, Any>{
                            if let status = json["status"] as? Bool{
                                if status == true{
                                    if let message = json["message"] as? Dictionary<String, Any>{
                                        if let price = message["total_price"] as? Int{
                                            DispatchQueue.main.async {
                                                self.priceLbl.text = "Total Price : \(price) SAR"
                                            }
                                        }
                                    }
                                }
                            }
                        }else{
                            DispatchQueue.main.async {
                                //self.errorMessage.alpha = 1
                                self.view.endEditing(true)
                            }
                        }
                    }
                    break
                    
                case .failure(_):
                    print(response.result.error!)
                    break
                    
                }
            }
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
