//
//  PostCarDateViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 2.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol LocationDelegat {
    func addLocation(location:LocationCar)
}
class PostCarDateViewController: UIViewController,LocationDelegat {
    func addLocation(location: LocationCar) {
        self.cityLbl.text = location.city
        self.countryLbl.text = location.country
        self.location = location
    }
    
    
    
    
    let dateFormatter = DateFormatter()
    @IBOutlet weak var dateFromTextFild : UITextField!
    @IBOutlet weak var dateToTextFild : UITextField!
    @IBOutlet weak var countryLbl: UILabel!
    
    @IBOutlet weak var postBtn: UIButton!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    var location : LocationCar?
    var car : Car?
    var imagesUrl = [String]()
    var dateTo : Date?
    var dateFrom : Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUpButtom(lable: cityLbl)
        setUpButtom(lable: countryLbl)
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "dd.MMM.yyyy"
        
        
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *){
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(dateChanged), for: .allEvents)
        dateFromTextFild.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action:   #selector(datePickerDone))
        let toolBar  = UIToolbar.init(frame: CGRect(x:0,y:0,width:view.bounds.size.width,height: 45))
        toolBar.setItems([doneButton], animated: true)
        dateFromTextFild.inputAccessoryView = toolBar
               
               
        datePicker2.datePickerMode = .date
        if #available(iOS 13.4, *){
            datePicker2.preferredDatePickerStyle = .wheels
        }
        datePicker2.addTarget(self, action: #selector(dataChanged2), for: .allEvents)
        dateToTextFild.inputView = datePicker2
        let toolBar2 = UIToolbar.init(frame: CGRect(x:0,y:0,width:view.bounds.size.width,height:45))
        let doneButton2 = UIBarButtonItem.init(title: "Done", style: .done, target: self,action:#selector(datePickerDone2))
        toolBar2.setItems([doneButton2], animated: true)
        dateToTextFild.inputAccessoryView = toolBar2
        
        
//        let mapViewController = storyboard?.instantiateViewController(identifier:  "MapSearchViewController.swift") as MapSearchViewController?
        
        
       // mapViewController?.delegate  = self as! LocationDelegat
        
        
    }
    
    @objc func datePickerDone(){
           
        dateFromTextFild.resignFirstResponder()
      
    }
    @objc func dateChanged(){
        dateFrom = datePicker.date
        dateFromTextFild.text = "\(dateFormatter.string(from:datePicker.date))"
    }
       
       
    @objc func dataChanged2(){
        dateTo = datePicker2.date
       
        dateToTextFild.text = "\(dateFormatter.string(from: datePicker2.date))"
    }
    @objc func datePickerDone2(){
        dateToTextFild.resignFirstResponder()
       
    }
    
    func setUpButtom(lable:UILabel){
        lable.backgroundColor = .white
        lable.layer.cornerRadius = 10
        lable.layer.borderColor = UIColor.white.cgColor
        lable.clipsToBounds = true
        
    }
    
    @IBAction func PostCar(_ sender: Any) {
        let authID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let ref = db.collection("cars")
        let doc = ref.document()
        let docId = doc.documentID
        
      
        doc.setData(["carId":docId,"ownerId":authID as Any  ,"brend": self.car!.brend,"model":self.car!.model,"passengers":self.car!.doors ,"consumation":self.car!.consumption,                                     "price":self.car!.rent,"speed":self.car!.speed,"year":self.car!.year,
                     "dateFrom":dateFromTextFild.text!,
"dateTo":dateToTextFild.text!,"imagesUrl":imagesUrl,"city":location!.city,
                                            "country":location!.country,
                        "longitude":location!.longitude,
                                        "latitude":location!.latitude
        ]){(error) in
                if error != nil {
                Toast.showToast(message: error!.localizedDescription, viewController: self)
                }else {
                  
                   
                     let homeControllre  = self.storyboard?.instantiateViewController(identifier: "HomePage")
                                   as? TabBarController
                       self.view.window?.rootViewController = homeControllre
                    
                        
                    
    
                   Toast.showToast(message: "Succes", viewController: self)
                    
                                   
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMap"){
            let vc = segue.destination as! MapSearchViewController
            vc.delegate = self
        }
    }
    

}

   
    

