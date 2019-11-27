//
//  MapViewController.swift
//  ConcertSpotter
//
//  Created by Matthew Lambert on 11/6/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class HomeViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 50000
    var lat = 0.0;
    var long = 0.0;
    override func viewDidLoad() {
         checkLocationServices()
         /*
         let locationString = String(lat) + "," + String(long)
         let baseURL = "https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey=nloLny4RAVOrwufbVORPtcbFGdxG5QCV&latlong=" + locationString + "&keyword=music"
         print(baseURL);
         
         
         */
        // Network request snippet
        
        }
        
        
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
                print("***********************************************")
                let locationString =  String(lat) + "," + String(long)
                let url = URL(string: "https://app.ticketmaster.com/discovery/v2/events.json?size=1&apikey=nloLny4RAVOrwufbVORPtcbFGdxG5QCV&latlong=" + locationString + "&keyword=music")!
                let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
                session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
                let task = session.dataTask(with: url) { (data, response, error) in
                   if let error = error {
                      print(error.localizedDescription)
                   } else if let data = data,
                      let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                      print(dataDictionary)
                    
                      // TODO: Get the posts and store in posts property
                      // TODO: Reload the table view
                  }
                }
                task.resume()
                print("***********************************************")
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
            print(location.coordinate.longitude , " " ,location.coordinate.latitude)
            lat = location.coordinate.latitude;
            long = location.coordinate.longitude;
            
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



