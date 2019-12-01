//
//  MapViewController.swift
//  ConcertSpotter
//
//  Created by Matthew Lambert on 11/6/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation
class HomeViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()

    let regionInMeters: Double = 5000
    var ticketInfo = [Ticket]()
    var checked  = false;
    var lat = 0.0;
    var long = 0.0;
    override func viewDidLoad() {
        
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        print("************************LatLong************************")
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = (locValue.latitude)
        long = (locValue.longitude)
        print("************************LatLong************************")
        checkLocationServices()
        //ticketInfo = ticketMasterApi.init().request(latlong: "37.785834,-122.406417", genreKey: "music")
        createMap()
        
        
    }
    
    /*
    @IBAction func logoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
 */
    
    func createMap()
    {
        let genreKey = "music"
        let url = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=pLOeuGq2JL05uEGrZG7DuGWu6sh2OnMz"
        let latlong  = String(lat) + "," + String(long)
        print("************************LatLong2************************")
        print(latlong)
        print("************************LatLong2************************")
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
                                            self.ticketInfo.append(Ticket(concertName: name ??  "", longitude: longitude, latitude: latitude, url: url ?? "", venueName: venueName ?? "", minPrice: b ?? 0.0))
                                        }
                                    }
                                }
                            }
                           
                        }
                        for i in self.ticketInfo
                        {
                            print("concert name: ", i.concertName)
                            print("venue name: ", i.venueName)
                            print("url: ", i.url)
                            print("min: " , i.minPrice)
                            print("longitude: ", i.longitude)
                            print("latitude: ", i.latitude, "\n")
                        }
                        
                    }
                    self.createAnnotations()
                }
                
                task.resume()

        
    }
        func createAnnotations()
        {
            for ticket in ticketInfo{
                let annotations = MKPointAnnotation()
                annotations.title = ticket.venueName
                let lat = Double(ticket.latitude) ?? 0.0
                let long = Double(ticket.longitude) ?? 0.0
                annotations.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: long )
                print(ticket.venueName,",",lat,",",long)
                map.addAnnotation(annotations)
            }
        }
        
     /*
    func requestNewConcerts(latLong:String, genreKey:String)
        {
            ticketCaller.request(latlong: latLong, genreKey: genreKey)
            { result in
                switch result{
                case .success(let ticketInfo):
                    for i in ticketInfo
                    {
                        print(i.venueName)
                        print(i.concertName)
                        print(i.minPrice)
                        print(i.longitude)
                        print(i.latitude)
//                        where you will put pins
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }
 */
        func setupLocationManager() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        
        
        func centerViewOnUserLocation() {
            if let location = locationManager.location?.coordinate {
                let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                map.setRegion(region, animated: true)
                
            }
        }
        
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                setupLocationManager()
                checkLocationAuthorization()
            } else {
                // Show alert letting the user know they have to turn this on.
            }
        }
        
        
        func checkLocationAuthorization() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                map.showsUserLocation = true
                centerViewOnUserLocation()
                locationManager.startUpdatingLocation()
                
                break
            case .denied:
                // Show alert instructing them how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                // Show an alert letting them know what's up
                break
            case .authorizedAlways:
                break
            @unknown default:
                break;
            }
        }
}
    extension HomeViewController: CLLocationManagerDelegate{
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            //print(location.coordinate.longitude , " " ,location.coordinate.latitude)
            lat = location.coordinate.latitude
            long = location.coordinate.longitude
            map.setRegion(region, animated: true)
            
            
        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


