//
//  DiscoverViewController.swift
//  ConcertSpotter
//
//  Created by Sofia Marquez on 11/22/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import AlamofireImage

class DiscoverViewController: UIViewController{
    
    var tickerCaller = ticketMasterApi.init()
    @IBOutlet weak var concertImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.reloadData()
        let imageUrl = URL(string: "https://s1.ticketm.net/dam/a/8c2/1e84234c-695c-4f3f-931a-a3ade43038c2_928391_ARTIST_PAGE_3_2.jpg")
        concertImage.af_setImage(withURL: imageUrl!)
        nameLabel.text = "Ariana Grande and Friends"
        dateLabel.text = "January 20, 2020"
        locationLabel.text = "Honda Center"
        
    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ConcertCell") as! ConcertCell
//        let cell = UITableViewCell()
//        let concert = concerts[indexPath.row]
//        let name = concert["name"] as! String
//
//        cell.textLabel?.text = "Hello"
//        let imageUrl = URL(string: )
//        cell.concertImage.af_setImage(withURL: imageUrl!)
//        return cell
//    }
    
}
