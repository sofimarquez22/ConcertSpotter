//
//  SignInView.swift
//  ConcertSpotter
//
//  Created by Frank Duenez on 11/6/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import Firebase

class SignInView: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil {
                print("success")
                self.performSegue(withIdentifier: "OnLoggingUserIn", sender: nil)
            } else {
                print(error)
                print("error can't sign in")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10

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

}
