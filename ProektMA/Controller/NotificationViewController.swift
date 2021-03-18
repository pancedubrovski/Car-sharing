//
//  NotificationViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 1.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class NotificationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var list = [Notification]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getDate()
        // Do any additional setup after loading the view.
    }
    
    
    
    func getDate(){
        let authId = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()
        db.collection("rentedCars").whereField("ownerId", isEqualTo: authId).getDocuments(){(result,error) in
            if error != nil {
                Toast.showToast(message: error!.localizedDescription, viewController: self)
            }
            else {
               
                
                for document in result!.documents {
                    let brend = document["brend"] as! String
                    let model = document["model"] as! String
                    let year = document["year"] as! String
                    let firstName = document["firstName"] as! String
                    let lastName = document["lastName"] as! String
                    let phone = document["phone"] as! String
                    let total = document["total"] as! Float
                    let dateFrom = document["dateFrom"] as! String
                    let dateTo = document["dateTo"] as! String
                    
                    self.list.append(Notification(user: User(firstName: firstName, lastName: lastName, phone: phone), car: CarView(brend: brend, model: model, year: year), total: total,dateFrom:dateFrom,dateTo:dateTo))
                    
                    
                }
                self.tableView.reloadData()
                    
                
               
                
                
            }
        }
        
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
extension NotificationViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notifCell",for:indexPath)
        as! NotificationTableViewCell
        
        let n = list[indexPath.row]
        cell.carInfolbl.text = n.car.brend + " " + n.car.model + " " + n.car.year + "  " + n.dateFrom + " " + n.dateTo
        cell.userInfoLbl.text = n.user.firstName + " " + n.user.lastName + " " + n.user.phone
        cell.sumLbl.text = "Total: \(n.total)$"
        
        
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: 1)
        cell.layer.addSublayer(border)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    
}
