//
//  MapSearchViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 11.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



protocol HandleMapMovie: class {
    func  dropPinZoomIn(placemark: MKPlacemark)
}

class MapSearchViewController: UIViewController {
    
    @IBOutlet weak var sendBtn: UIButton!
     var delegate:LocationDelegat?
    
    var localManager:CLLocationManager?
    var locationT : CLLocation?


    @IBOutlet weak var locationBtn: UIButton!
    
    
    var annotaionView : MKPointAnnotation? = nil
    var country:String = ""
    var city : String = ""
    var location : LocationCar?
    
    
     var resultSearchController: UISearchController!
   // week var mapDataDelegate : mapData?
    
        
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        localManager = CLLocationManager()
        localManager?.delegate = self
        localManager?.requestAlwaysAuthorization()
       
      //  mapView.delegate = self
        
        
        let resultController = storyboard?.instantiateViewController(identifier:  "SearchResultMapViewController.swift") as SearchResultMapViewController?
        
        resultSearchController = UISearchController(searchResultsController: resultController)
        resultSearchController.searchResultsUpdater = resultController
        
        
        resultController!.handleMapSearchDelegate = self
        
        let searchBar = resultSearchController!.searchBar
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
        mapView.addGestureRecognizer(gestureRecognizer)
        
      
        
        

    }
    @IBAction func getLocation(_ sender: Any) {
        localManager = CLLocationManager()
        localManager?.delegate = self
        localManager?.requestAlwaysAuthorization()
        localManager?.startUpdatingLocation()
    }
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
      
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotaionView = annotation
       
    
        mapView.addAnnotation(annotation)
    }
    
    
    @IBAction func sendMapLocation(_ sender: Any) {

        if (annotaionView != nil){
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: (annotaionView?.coordinate.latitude)!, longitude: (annotaionView?.coordinate.longitude)!), completionHandler: {(placemarks, error)-> Void in
                if let t = placemarks?.first?.country {
                   
                    self.city = (placemarks?.first?.locality)!
                    self.country = t
                    let l = LocationCar(longitude: (self.annotaionView?.coordinate.longitude)!, latitude: (self.annotaionView?.coordinate.latitude)!, city: self.city, country: self.country)
                    
                        self.delegate?.addLocation(location: l)
                                    
                    self.navigationController?.popViewController(animated: true)

                }
            } )
           
        }
            
//            let loc = LocationCar(longitude: (annotaionView?.coordinate.longitude)!, latitude: (annotaionView?.coordinate.latitude)!)
      //      mapDataDelegate?.addData(location:loc)
//        }
        
    
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
extension MapSearchViewController : HandleMapMovie {
    
    func dropPinZoomIn(placemark:MKPlacemark) {
      
          mapView.removeAnnotations(mapView.annotations)
//          let annotation = MKPointAnnotation()
//          annotation.coordinate = placemark.coordinate
//          annotation.title = placemark.name
//
//          if let city = placemark.locality,
//              let state = placemark.administrativeArea {
//                  annotation.subtitle = "\(city) \(state)"
//          }
//
//          mapView.addAnnotation(annotation)
        
          let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
         let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
          mapView.setRegion(region, animated: true)
    }
}
//extension MapSearchViewController : MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(handleTap))
//
//
//        // center the mapView on the selected pin
//        let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: mapView.region.span)
//        mapView.setRegion(region, animated: true)
//        print(view.annotation?.coordinate)
//    }
//
//}
extension MapSearchViewController : CLLocationManagerDelegate {
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationT = locations.last!
        let centre =  CLLocationCoordinate2D(latitude: (locationT?.coordinate.latitude)!,longitude:
                          (locationT?.coordinate.longitude)!)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: centre, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(MKPlacemark(coordinate: centre))

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Toast.showToast(message: error.localizedDescription, viewController: self)
    }
}
