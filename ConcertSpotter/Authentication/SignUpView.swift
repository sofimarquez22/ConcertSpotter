//
//  SignUpView.swift
//  ConcertSpotter
//
//  Created by Frank Duenez on 11/6/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import Firebase



class SignUpView: UIViewController {
    
//    var ref: DatabaseReference!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailField.placeholder = "Email:"
//        passwordField.placeholder = "Password:"
        signUpButton.layer.cornerRadius = 10
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func signUpAction(_ sender: Any) {
        
        guard let password = passwordField.text else { return }
        guard let email = emailField.text else  { return }
        guard let first = firstNameField.text else  { return }
        guard let last = lastNameField.text else  { return }
                
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            
            if error == nil{
                
                
                guard let user = Auth.auth().currentUser?.uid else{return}

                let personObject = [
                    "email": email,
                    "firstName": first,
                    "lastName": last
                ] as [String:Any]
                
                self.ref.child("users").child(user).setValue(personObject)
                
                self.performSegue(withIdentifier: "OnSigningUserIn", sender: nil)
                print("User Created")
                
            } else {
                print("failed ")
            }
            
        }
        
        
        
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
