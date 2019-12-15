//
//  AccountViewController.swift
//  ConcertSpotter
//
//  Created by Sofia Marquez on 11/22/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var manage: UILabel!
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var tellFriend: UILabel!
    

    let userID = Auth.auth().currentUser?.uid
    var ref : DatabaseReference!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        manage.layer.borderWidth = 2.0
        manage.layer.cornerRadius = 8
        history.layer.borderWidth = 2.0
        history.layer.cornerRadius = 8
        tellFriend.layer.borderWidth = 2.0
        tellFriend.layer.cornerRadius = 8
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2;
        self.profileImage.clipsToBounds = true;
        self.profileImage.layer.borderWidth = 3.0;
        self.profileImage.layer.borderColor = UIColor.black.cgColor;
        imagePicker.delegate = self
        
        self.getUser()
        
        
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = true

            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func getUser(){
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let first = value?["firstName"] as? String ?? ""
            let last = value?["lastName"] as? String ?? ""
            self.username.text = first + " " + last
            print("read")
        }) { (error) in
            print("not working")
        }
    }


    func createProfileChangeRequest(photoUrl: URL? = nil, name: String? = nil, _ callback: ((Error?) -> ())? = nil){
        if let request = Auth.auth().currentUser?.createProfileChangeRequest(){
            if let name = name{
                request.displayName = name
            }
            if let url = photoUrl{
                request.photoURL = url
            }

            request.commitChanges(completion: { (error) in
                callback?(error)
            })
        }
    }
}

extension AccountViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController( _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]){
        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
