//
//  RegisterViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 1.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore



class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextFild: UITextField!
    @IBOutlet weak var passwrodTextFild: UITextField!
    @IBOutlet weak var cpasswordTextFild: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func registerUser(){
        if (emailTextFild.text!.isEmpty || passwrodTextFild.text!.isEmpty  || firstNameTextField!.text!.isEmpty || lastNameTextField.text!.isEmpty){
            Toast.showToast(message: "text field blanck", viewController: self)
        }
        if (passwrodTextFild.text != cpasswordTextFild.text){
            Toast.showToast(message:"your password is not same as confilm password" , viewController: self)
        }else {
            Auth.auth().createUser(withEmail: emailTextFild.text!, password: passwrodTextFild.text!){ (authResult,Error) in
                if let error = Error {
                    print(error)
                    self.showToastMessage(message: error)
                } else {
                    
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["userId":authResult?.user.uid as Any  ,"firstName": self.firstNameTextField.text!,"lastName":self.lastNameTextField.text!,"phone":self.phoneTextField.text! as Any,"country":self.countryTextField.text! as Any]){(error) in
                        if error != nil {
                            Toast.showToast(message: error!.localizedDescription, viewController: self)
                        }else {
                             self.saveData()
                             self.LoginToHome()
                            
                        }
                    }
                }
            }
        }
    }
    @IBAction func register(_ sender: Any) {
        registerUser()
  //      LoginToHome()
    }
    func showToastMessage(message:Error){
        Toast.showToast(message:message.localizedDescription ,viewController:self)
    }
    func LoginToHome(){
        
        let homeControllre  = storyboard?.instantiateViewController(identifier: "HomePage")
             as? TabBarController
               view.window?.rootViewController = homeControllre
    }
    func saveData(){
        let user = User.init(email: emailTextFild.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, phone: phoneTextField.text!, country: countryTextField.text!)
        let userDefault = UserDefaults.standard
        let encoder = JSONEncoder()
        do{
            let  encodeData = try encoder.encode(user)
            userDefault.set(encodeData,forKey: "userInfo")
        } catch {
            Toast.showToast(message: "nastana greska", viewController: self)
        }
    }
}
