//
//  LoginViewController.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 28.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
  
    var handle: AuthStateDidChangeListenerHandle?

    @IBOutlet weak var LogoImg: UIImageView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       // LogoImg.image = UIImage(named:"car_rental")
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func tapLogin(_ sender: Any) {
        if (emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty){
            Toast.showToast(message: "Fild the input", viewController: self)
        }else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!){
                results, error in
                guard error == nil else  {
                    Toast.showToast(message: error!.localizedDescription, viewController: self)
                    return
                    
                }
                
                let homeControllre  = self.storyboard?.instantiateViewController(identifier: "HomePage")
                            as? TabBarController
                self.view.window?.rootViewController = homeControllre
                
              }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
      handle =  Auth.auth().addStateDidChangeListener {(auth,user) in
            if user != nil {
                let homeControllre  = self.storyboard?.instantiateViewController(identifier: "HomePage")
                            as? TabBarController
                self.view.window?.rootViewController = homeControllre
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
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
