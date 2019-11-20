//
//  User.swift
//  ConcertSpotter
//
//  Created by Frank Duenez on 11/13/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import Foundation


class User
{
    var email: String
    var firstName: String
    var lastName: String

    init(email: String, firstName: String, lastName: String) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
    
}
