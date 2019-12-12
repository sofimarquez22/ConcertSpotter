//
//  DetailsViewController.swift
//  ConcertSpotter
//
//  Created by Sofia Marquez on 12/6/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AlamofireImage

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var concertName: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var minimumPrice: UILabel!
    @IBOutlet weak var getTickets: UIButton!
    
    
    var annotations:MKPointAnnotation = MKPointAnnotation()
    var details:Ticket = Ticket(concertName: "", longitude: "", latitude: "", url: "", venueName: "" , imageUrl: "", minPrice: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(details.minPrice)
//        print(details.concertName)
//        print(details.venueName)
//        print(details.imageUrl)
//        print(details.url)
//        print(details.count)
        getTickets.layer.cornerRadius = 8
//
        let poster = URL(string: details.imageUrl)
        posterView.af_setImage(withURL: poster!)
        concertName.text = details.concertName
        venueName.text = details.venueName
        minimumPrice.text = "Lowest Price: " + String(details.minPrice)
    }
    
    @IBAction func getTickets(_ sender: Any) {
        if let url = URL(string: details.url){
            UIApplication.shared.open(url)
        }
    }

}
