//
//  ListCarDetailViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 7.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//
import Foundation
import UIKit
import FirebaseFirestore

class ListCarDetailViewController: UIViewController {

    let datePicker = UIDatePicker()
    let datePicker2 = UIDatePicker()
    
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var ownerLbl: UILabel!
    var images = [String]()
    let dateFormatter = DateFormatter()
    var car : postCar?
    var user : User?
    
    @IBOutlet weak var ListImageScroll: UIScrollView!
   
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var carPostionlbl: UILabel!
    @IBOutlet weak var carSpecificationLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        db.collection("users").whereField("userId", isEqualTo: car?.ownerId).getDocuments() {(results , err) in
            if err != nil {
                print(err?.localizedDescription)
                return
            }
            else {
                for e in results!.documents {
                    let firestName = e["firstName"] as! String
                    let lastName = e["lastName"] as! String
                    let number = e["phone"] as! String
                    self.user = User(firstName: firestName, lastName: lastName, phone: number)
                    self.ownerLbl.text = "\(firestName)  \(lastName)"
                    self.numberLbl.text =  number

                    
                    
                }
            
            }
            
        }
            
        setUpButtom(lable: carSpecificationLbl)
        setUpButtom(lable: carPostionlbl)
        setUpButtom(lable: ownerLbl)
       
        carPostionlbl.text = "\(car!.location.city),\(car!.location.country)"
        carModel.text = "\(String(describing: car!.brend))     \(String(describing: car!.model))  \(car!.year)"
        carSpecificationLbl.text = "\(String(describing: car!.passengers))  no.passengers \n \(String(describing: car!.consumation))  consumption \n \(String(describing: car!.speed)) km\\h "
        // Do any additional setup after loading the view
       
       
        for image in car!.imagesUrl {
            images.append(image)
        }
        
        setUpImage()
    }
    func setUpButtom(lable:UILabel){
          lable.backgroundColor = .white
          lable.layer.cornerRadius = 10
          lable.layer.borderColor = UIColor.white.cgColor
          lable.clipsToBounds = true
          
      }

   
   
   
  
    
    
    
    
    
    func setUpImage(){
        
        for i in 0..<images.count{
            let url = URL(string: images[i])!
            let imageView = UIImageView()

                if let image = try? Data(contentsOf: url){
                    imageView.image  =  UIImage(data:image)!
           
                let xPostion = self.view.frame.width * CGFloat(i)
                imageView.frame = CGRect(x:xPostion,y:0,width: self.ListImageScroll.frame.width,height: self.ListImageScroll.frame.height)
                
                    ListImageScroll.contentSize.width = ListImageScroll.frame.width * CGFloat(i + 1)
               
                self.ListImageScroll.addSubview(imageView)
            }
            
        }
    }
        
        
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "confId"){
           //  let vc = segue.destination as! ImageViewController
            let vc = segue.destination as! ConformeRentViewController
            vc.car = self.car
         
          
           
            let dateFormater = DateFormatter()
            dateFormater.dateFormat = "dd.MMM.yyyy"
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")

            print(dateFormater.date(from: car!.dataTo)!)
            let date = dateFormater.date(from: car!.dataFrom)
            let dateTo = dateFormater.date(from: car!.dataTo)
            print(date!)
            print(dateTo!)
            
            print(Calendar.current.dateComponents([.day], from: date!, to: dateTo!))
            let numberOfDays = Calendar.current.dateComponents([.day], from: date!, to: dateTo!)
            vc.days = numberOfDays.day
            vc.total = Float(numberOfDays.day!) * car!.price
            vc.user  = self.user
            

            
        }
    }


}
