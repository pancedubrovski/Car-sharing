//
//  ListCarViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 6.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ListCarViewController: UIViewController {
    @IBOutlet weak var cityTextFild: UITextField!
    
    @IBOutlet weak var dateFromTextField :UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    var cars = [postCar]()
    var carsView = [CarView]()
    var dateTo: Date?
    var dateFrom: Date?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        dateFormatter.dateFormat = "dd.MMM.yyyy"
        
        
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *){
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.addTarget(self, action: #selector(dateChanged), for: .allEvents)
        dateFromTextField.inputView = datePicker
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action:   #selector(datePickerDone))
        
     
        
        let toolBar  = UIToolbar.init(frame:  CGRect(x:200,y:200,width:view.bounds.size.width,height: 45))
        toolBar.setItems([doneButton], animated: true)
        dateFromTextField.inputAccessoryView = toolBar
    
               
        datePicker2.datePickerMode = .date
        if #available(iOS 13.4, *){
            datePicker2.preferredDatePickerStyle = .wheels
        }
        datePicker2.addTarget(self, action: #selector(dataChanged2), for: .allEvents)
        dateToTextField.inputView = datePicker2
        let toolBar2 = UIToolbar.init(frame: CGRect(x:0   ,y:0,width:view.bounds.size.width,height:45))
        let doneButton2 = UIBarButtonItem.init(title: "Done", style: .done, target: self,action:#selector(datePickerDone2))
        toolBar2.setItems([doneButton2], animated: true)
        dateToTextField.inputAccessoryView = toolBar2
        // Do any additional setup after loading the view.
    }

    @objc func datePickerDone(){
          
          dateFromTextField.resignFirstResponder()
     
    }
    @objc func dateChanged(){
     ////   dateFrom = datePicker.date
        dateFromTextField.text = "\(dateFormatter.string(from:datePicker.date))"
    }
      
      
    @objc func dataChanged2(){
      ///  dateTo = datePicker2.date
        dateToTextField.text = "\(dateFormatter.string(from: datePicker2.date))"
    }
    @objc func datePickerDone2(){
        dateToTextField.resignFirstResponder()
      
    }
      

    
    @IBAction func searchCars(_ sender: Any) {
        
       

         
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "carListSegue"){
             let vc = segue.destination as! ListCarRentViewController
            vc.city = self.cityTextFild.text!
            vc.dateFrom = self.dateFromTextField.text!
            vc.dateTo = self.dateToTextField.text!
        }
    
    }
    

}
