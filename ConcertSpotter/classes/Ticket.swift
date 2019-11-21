//
//  Ticket.swift
//  ConcertSpotter
//
//  Created by Frank Duenez on 11/20/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit

class Ticket
{
    
    var concertName:String
    var longitude:String
    var latitude:String
    var url:String
    var venueName:String
    var minPrice:Double
    init(concertName:String, longitude:String, latitude:String, url:String, venueName:String, minPrice:Double)
    {
        self.concertName = concertName
        self.longitude = longitude
        self.latitude = latitude
        self.url = url
        self.venueName = venueName
        self.minPrice = minPrice
    }
    
    
}
