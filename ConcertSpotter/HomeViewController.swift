//
//  ViewController.swift
//  ConcertSpotter
//
//  Created by Sofia Marquez on 11/5/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        ticketMasterApi.init().request(latlong: "37.785834,-122.406417", genreKey: "music")
        // Do any additional setup after loading the view.
    }


}

