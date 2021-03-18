//
//  MapViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 12.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate {
    
    let baseCoordinate = CLLocationCoordinate2DMake(44.1487225,-87.5684114)

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        // Do any additional setup after loading the view.
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended{
            let locationInView = sender.location(in: mapView)
            let tappedCoordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(coordinate: tappedCoordinate)
        }
    }
    
    func addAnnotation(coordinate:CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    func setupMap(){
        let region = MKCoordinateRegion(center: baseCoordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.region = region
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
