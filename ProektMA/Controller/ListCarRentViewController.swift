//
//  ListCarRentViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 6.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ListCarRentViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var listCarTable: UITableView!
    
    var carList = [CarView]()
    var cars = [postCar]()
    
    var city : String?
    var dateFrom : String?
    var dateTo : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listCarTable.dataSource = self
        listCarTable.delegate  = self
 
       
        getData()
        
        
    }
    func getData(){
        let db = Firestore.firestore()
        
        db.collection("cars").whereField("city", isEqualTo: city ?? "Skopje").whereField("dateFrom" , isEqualTo:  dateFrom!)
        .whereField("dateTo", isEqualTo:  dateTo!)
        
                .getDocuments(){ (querySnapshot, err ) in
                    if let err = err {
                        print(err)
                    }else {
                        for document in querySnapshot!.documents {
                            
                            let brend = document["brend"] as? String ?? ""
                            let carId = document["carId"] as? String ?? ""
                            let city = document["city"] as? String ?? ""
                            let consumation = document["consumation"] as? String ?? ""
                            let dataFrom = document["dateFrom"] as! String
                            let dateTo = document["dateTo"] as! String
                            let model = document["model"] as! String
                            let ownerId = document["ownerId"] as! String
                            let imagesUrl = document["imagesUrl"] as! [String]
                            let price = document["price"] as! Float
                            let year = document["year"] as! String
                            let speed = document["speed"] as! String
                            let passengers = document["passengers"] as! String
                            let country = document["country"] as! String
                            let longitude = document["longitude"] as! Double
                            let latitude = document ["latitude"] as! Double
 
                            let c = CarView(imageUrl: imagesUrl[0], model: model,brend:brend,
                                            price: price, passenges: passengers,
                                           consumption: consumation, speed: speed, year: year)

                            var location = LocationCar(longitude: longitude, latitude: latitude, city: city, country: country)
                            self.carList.append(c)
                            self.cars.append(postCar.init(brend: brend, carId:
                            carId,
                                         location: location, consumation: consumation,
                                         dataFrom: dataFrom, dataTo:dateTo,
                                         imagesUrl: imagesUrl, model: model,
                                         ownerId: ownerId, price: price,
                                         speed: speed, year: year,passengers:passengers))
                        }
                        self.listCarTable.reloadData()
                    }
                    
            }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
      }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = listCarTable.dequeueReusableCell(withIdentifier: "carCellId",for: indexPath) as! TableViewCell
        cell.carModel.text = " \(carList[indexPath.row].brend) \(carList[indexPath.row].model) \(carList[indexPath.row].year)"
           cell.lblPrice.text = "\(carList[indexPath.row].price)$"
       
        
            let url = URL(string: carList[indexPath.row].imageUrl)!
            if let image = try? Data(contentsOf: url){
                cell.carImage.image =  UIImage(data:image)
            }
            
       // let view = UIVIew(cell).
       // view.cont
         // cell.contentView.
     
//            cell.layer.cornerRadius = 10
//            cell.layer.borderWidth = 2
//        cell.layer.shadowRadius = 10
//        cell.layer.borderColor =  UIColor.white.cgColor
        let verticalPadding: CGFloat = 16

           let maskLayer = CALayer()
           maskLayer.cornerRadius = 20   
           maskLayer.backgroundColor = UIColor.white.cgColor
           maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
           cell.layer.mask = maskLayer

//        cell.layer.shadowOpacity =  0.5
//        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
      //  cell.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
          
           
           
        
          return cell
      }

    
       
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "carDetilsegue"){
            let vc = segue.destination as! ListCarDetailViewController
            if let indexPath = self.listCarTable?.indexPathForSelectedRow {
                vc.car = cars[indexPath.row]
            }
        }
    }
    

}
