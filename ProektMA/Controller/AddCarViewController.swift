//
//  AddCarViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 12.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit

protocol mapData : class {
    func addData(location: LocationCar)
}

class AddCarViewController: UIViewController {
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBOutlet weak var consumationTextField: UITextField!
    @IBOutlet weak var passengersTextField: UITextField!
    @IBOutlet weak var speedtextField: UITextField!
    @IBOutlet weak var yeraTextFild: UITextField!
    @IBOutlet weak var modelLbl: UITextField!
    @IBOutlet weak var brendLbl: UITextField!
    @IBOutlet weak var mapBtn: UIButton!
  
    var location : LocationCar?
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "Color")
       
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        // put background view as the most background subviews of stack view
        stackView.insertSubview(backgroundView, at: 0)

        // pin the background view edge to the stack view edge
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: stackView.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
       
    }
    
   
    
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    

    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToImageCar"){
        let vc = segue.destination as! ImageViewController
            vc.car = Car(brend: brendLbl.text!, model: modelLbl.text!, rent: (priceTextField.text! as NSString).floatValue, doors: passengersTextField.text!, consumption: consumationTextField.text!, speed: speedtextField.text!, year: yeraTextFild.text!)
        }
    }
    

}
extension mapData{
    func addData(location:LocationCar){
        //locationCar.init(longitude: location.longitude, latitude: location.latitude)
    }
}
