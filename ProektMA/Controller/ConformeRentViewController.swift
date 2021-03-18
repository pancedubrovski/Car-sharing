//
//  ConformeRentViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 10.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import MapKit
import FirebaseAuth
import FirebaseFirestore

class ConformeRentViewController: UIViewController {
    
    var car :postCar?
    var total: Float?
    var days: Int?
    var user : User?

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var dateTo: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var dateFrom: UILabel!
    @IBOutlet weak var carLbl: UILabel!
    
    var annotaionView : MKPointAnnotation?
    
    
    override func viewWillAppear(_ animated: Bool) {
       
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpButtom(lable:  carLbl)
        setUpButtom(lable:  dateFrom)
        setUpButtom(lable: dateTo)
        setUpButtom(lable: totalLbl)
        
        
        mapView.delegate = self

        totalLbl.text = "\(String(describing: days!)) X \(car!.price) = \(total!)$"
        dateTo.text = car!.dataTo
        dateFrom.text = car!.dataFrom
        carLbl.text = car!.brend + "  " + car!.model + " " + car!.year
        // Do any additional setup after loading the view.
        let london = MKPointAnnotation()
        london.title = car!.brend
        london.coordinate = CLLocationCoordinate2D(latitude:car!.location.latitude, longitude: car!.location.longitude)

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:car!.location.latitude, longitude: car!.location.longitude), span: span)
        DispatchQueue.main.async {
            
        
            self.mapView.setRegion(region, animated: true)
            self.mapView.addAnnotation(london)
        }
       
    }
    func setUpButtom(lable:UILabel){
        lable.layer.cornerRadius = 10
        lable.layer.borderColor = UIColor.white.cgColor
        lable.clipsToBounds = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func ConformeRent(_ sender: Any) {
        addRent()
    }
    func addRent(){
        let db = Firestore.firestore()
        let ref = db.collection("rentedCars")
        let doc = ref.document()
        let docId = doc.documentID
       
        doc.setData(["id":docId,"carId":car!.carId,"brend":car!.brend,"model":car!.model,"year":car!.year,"firstName":user!.firstName,"lastName":user!.lastName,"phone":user!.phone,
"ownerId":car!.ownerId,"total":total!,"dateFrom":car!.dataFrom,"dateTo":car!.dataTo]){ (error) in
            if error != nil {
                Toast.showToast(message: error!.localizedDescription, viewController: self)
            } else {
                let homeControllre  = self.storyboard?.instantiateViewController(identifier: "HomePage")
                            as? TabBarController
                self.view.window?.rootViewController = homeControllre
            }
            
         }
    }

}
extension ConformeRentViewController : MKMapViewDelegate {
    
}
