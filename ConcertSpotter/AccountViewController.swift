//
//  AccountViewController.swift
//  ConcertSpotter
//
//  Created by Sofia Marquez on 11/22/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var manage: UILabel!
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var tellFriend: UILabel!
    @IBOutlet weak var signOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
