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
    var ticketsArray = [Ticket]()
    init()
    {
        
    }
    //return object
    func request(latlong:String, genreKey:String, completionHandler: @escaping (Result<[Ticket], Error>) -> ()){
        
        let newUrl = URL(string: url + "&latlong=" + latlong + "&keyword=" + genreKey)!
        
        let request = URLRequest(url: newUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let t = dataDictionary["_embedded"] as! [String:Any]
                let temp = t["events"] as! [[String:Any]]

                for event in temp {
                    guard let images = event["images"] as? [[String:Any]] else{return}
                    var imageUrl:String = ""
                    for image in images{
                        if(image["width"] as? Int == 1024){
                            imageUrl = image["url"] as? String ?? ""
                            break
                        }
                    }
                    //guard let imageUrl = images[0]["url"] as? String else{return}
                    guard let info = event["_embedded"] as? [String:Any] else{return}
                    guard let venue = info["venues"]  as? [[String:Any]] else{return}
                    
                    if let location = venue[0]["location"] as? [String: Any]
                    {
                        if let longitude = location["longitude"] as? String
                        {
                            if let latitude = location["latitude"] as? String
                            {
//                                print(longitude)
//                                print(latitude)
                                if let range = event["priceRanges"] as? [[String: Any]]
                                {
                                    let b = range[0]["min"] as? Double
                                    let name = event["name"] as? String
                                    let url = event["url"] as? String
                                    let venueName = venue[0]["name"] as? String
                                    self.ticketsArray.append(Ticket(concertName: name ??  "", longitude: longitude, latitude: latitude, url: url ?? "", venueName: venueName ?? "",imageUrl: imageUrl , minPrice: b ?? 0.0))
                                }
                            }
                        }
                    }
                   
                }
//                for i in self.ticketsArray
//                {
//                    print("concert name: ", i.concertName)
//                    print("venue name: ", i.venueName)
//                    print("url: ", i.url)
//                    print("min: " , i.minPrice)
//                    print("longitude: ", i.longitude)
//                    print("latitude: ", i.latitude, "\n")
//                }
                completionHandler(.success(self.ticketsArray))
            }
            
            
        }
        task.resume()
        
    }
    
     func getArtistsId(keyword:String, completionHandler: @escaping (Result<[String], Error>) -> ()) {
         let baseURL = "https://app.ticketmaster.com/discovery/v2/attractions.json?apikey=pLOeuGq2JL05uEGrZG7DuGWu6sh2OnMz"
         let newUrl = URL(string: baseURL + "&keyword=" + keyword)!
         let request = URLRequest(url: newUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
         let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
         var ids: [String] = []
         
         let task = session.dataTask(with: request) { (data, response, error) in
             if let error = error {
                 print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let t = dataDictionary["_embedded"] as! [String:Any]
                 let temp = t["attractions"] as! [[String:Any]]
                 
                 for attraction in temp {
                     guard let info = attraction["_embedded"] as? [String:Any] else{return}
                     guard let upcomingEvents = info["upcomingEvents"]  as? [[String:Any]] else{return}
                     let id = attraction["id"] as! String
                     print(id)
                     ids.append(id)
                 
                        
                     
                 }
                 //print(dataDictionary)
             }
         }
         task.resume()
     }
      
     func getArtistsConcerts(attractionId:String, completionHandler: @escaping (Result<[Ticket], Error>) -> ()) {
         let newUrl = URL(string: url + "&attractionId=" + attractionId)!
         let request = URLRequest(url: newUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
         let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
         
         let task = session.dataTask(with: request) { (data, response, error) in
             if let error = error {
                 print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                 let t = dataDictionary["_embedded"] as! [String:Any]
                                 let temp = t["events"] as! [[String:Any]]

                                 for event in temp {

                                     guard let info = event["_embedded"] as? [String:Any] else{return}
                                     guard let venue = info["venues"]  as? [[String:Any]] else{return}

                                     if let location = venue[0]["location"] as? [String: Any]
                                     {
                                         if let longitude = location["longitude"] as? String
                                         {
                                             if let latitude = location["latitude"] as? String
                                             {
                 //                                print(longitude)
                 //                                print(latitude)
                                                 if let range = event["priceRanges"] as? [[String: Any]]
                                                 {
                                                     let b = range[0]["min"] as? Double
                                                     let name = event["name"] as? String
                                                     let url = event["url"] as? String
                                                     let venueName = venue[0]["name"] as? String
                                                    self.ticketsArray.append(Ticket(concertName: name ??  "", longitude: longitude, latitude: latitude, url: url ?? "", venueName: venueName ?? "", imageUrl: "", minPrice: b ?? 0.0))
                                                 }
                                             }
                                         }
                                     }

                                 }
                                 completionHandler(.success(self.ticketsArray))
                 //print(dataDictionary)
             }
        }
        task.resume()
    }
          
}
