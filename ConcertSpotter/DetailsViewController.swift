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

class DetailsViewController: UIViewController {

    var annotations:MKPointAnnotation = MKPointAnnotation()
    var details:Ticket = Ticket(concertName: "", longitude: "", latitude: "", url: "", venueName: "" , imageUrl: "", minPrice: 0.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        print(details.minPrice)
        print(details.concertName)
        print(details.venueName)
        print(details.imageUrl)
        print(details.url)
        

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
