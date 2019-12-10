//
//  DiscoverViewController.swift
//  ConcertSpotter
//
//  Created by Sofia Marquez on 11/22/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
   var tickerCaller = ticketMasterApi.init()
    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
//
//
//                self.tableView.reloadData()
//            }
//        }
//        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConcertCell") as! ConcertCell
//        let concert = concerts[indexPath.row]
//        let name = concert["name"] as! String
        
//        cell.nameLabel!.text = name
        
        return cell
    }
    
}
