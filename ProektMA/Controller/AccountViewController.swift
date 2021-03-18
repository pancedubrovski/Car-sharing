//
//  AccountViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 1.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class AccountViewController: UIViewController {

    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var emialLbl: UILabel!
    @IBOutlet weak var lastNameLb: UILabel!
    @IBOutlet weak var firstNamelbl: UILabel!
    
    
    var cars = [postCar]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        getUserData()
        getData()
        
        
        title = "Account"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sing out", style: .plain, target: self, action: #selector(singOut))
        
        
        if let data = UserDefaults.standard.data(forKey: "userInfo")
        {
            do {
                let decoder = JSONDecoder()
                let userInfo = try decoder.decode(User.self, from: data)
                firstNamelbl.text = userInfo.firstName
                lastNameLb.text = userInfo.lastName
                emialLbl.text = userInfo.email
                phone.text = userInfo.phone
                countryLbl.text = userInfo.country
            } catch {
                print("error")
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func singOut(){
        let user  = Auth.auth()
        do {
            try user.signOut()
            
        } catch let error as NSError{
            Toast.showToast(message: error.localizedDescription, viewController: self)
        }
        UserDefaults.standard.set(nil,forKey:"userInfo")
        let singInController = storyboard?.instantiateViewController(identifier: "loginController") as! LoginViewController
        view.window?.rootViewController = singInController
    }
    func getUserData(){
        let db = Firestore.firestore()
        
        let id = Auth.auth().currentUser!.uid as String
        db.collection("users").whereField("userId", isEqualTo: id)
                .getDocuments(){ (querySnapshot, err ) in
            if err != nil {
                print(err?.localizedDescription)
               return
            }
            else {
                for document in querySnapshot!.documents {
                  let firsName = document["firstName"] as? String ?? ""
                  let lastName = document["lastName"] as? String ?? ""
                  let phone = document["phone"] as? String ?? ""
                  let country = document["consumation"] as? String ?? ""
                    self.firstNamelbl.text = firsName
                    self.lastNameLb.text = lastName
                     self.phone.text = phone
                     self.countryLbl.text = country
                }
            }
        }
        
    }
    func getData(){
        let db = Firestore.firestore()
        print(Auth.auth().currentUser!.uid)
        let id = Auth.auth().currentUser!.uid as String
        db.collection("cars").whereField("ownerId", isEqualTo: id)
                .getDocuments(){ (querySnapshot, err ) in
            if err != nil {
                print(err?.localizedDescription)
               return
            }
            else {
                for document in querySnapshot!.documents {
                  let brend = document["brend"] as? String ?? ""
                  let cardId = document["carId"] as? String ?? ""
                  let city = document["city"] as? String ?? ""
                  let consumation = document["consumation"] as? String ?? ""
                  let dataFrom = document["dateFrom"] as? String ?? ""
                  let dateTo = document["dateTo"] as! String
                  let model = document["model"] as! String
                  let ownerId = document["ownerId"] as! String
                  let imagesUrl = document["imagesUrl"] as! [String]
                  let price = document["price"] as! Float
                  let year = document["year"] as! String
                  let speed = document["speed"] as! String
                  let passengers = document["passengers"] as! String
                  let location = LocationCar(longitude: document["longitude"] as! Double, latitude: document["latitude"] as! Double, city: document["city"] as! String, country: document["country"] as! String)
                  self.cars.append(postCar.init(brend: brend, carId:
                        cardId,
                                                location: location, consumation: consumation,
                                     dataFrom: dataFrom, dataTo:dateTo,
                                     imagesUrl: imagesUrl, model: model,
                                     ownerId: ownerId, price: price,
                                     speed: speed, year: year,passengers:passengers))
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
extension AccountViewController : UITableViewDelegate,UITableViewDataSource
{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersCarTableViewCell
        
        cell.brendLbl.text = "\(cars[indexPath.row].brend)  \(cars[indexPath.row].model)"
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
   
            
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction  = UITableViewRowAction(style: .destructive, title: "delete"){ (action,indexPath) in
            let db = Firestore.firestore()
            print(indexPath)
            let id = self.cars[indexPath.row].carId
            print(indexPath.row)
          
            db.collection("cars").document(id).delete()
            self.cars.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
        }
        return [deleteAction]
    }
       
   
        
    
}
