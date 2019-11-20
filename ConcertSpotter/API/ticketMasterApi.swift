//
//  ticketmassterApi.swift
//  ConcertSpotter
//
//  Created by Frank Duenez on 11/18/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//
import UIKit

class ticketMasterApi
{
    
    let url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=pLOeuGq2JL05uEGrZG7DuGWu6sh2OnMz"

    init()
    {
        
    }
    //return object
    func request(latlong:String, genreKey:String) {
        
        let newUrl = URL(string: url + "&latlong=" + latlong + "&keyword=" + genreKey)!
        
        let request = URLRequest(url: newUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
               
                print(dataDictionary)
                
                
            }
        }
        task.resume()
    }
          
}
