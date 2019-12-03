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
    var lat:Double = 0.0
    var long:Double = 0.0
    
    var ticketMap: [MKPointAnnotation: Ticket] = [:]
    
    
    var tickerCaller = ticketMasterApi.init()
    override func viewDidLoad() {
//        put latlong in string
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else { return }
        lat = (locValue.latitude)
        long = (locValue.longitude)
        let latlong  = String(lat) + "," + String(long)
        requestNewConcerts(latLong: latlong, genreKey: "music")
 
        map.delegate = self
    }
        
        
        
        
        
        
    
    func createAnnotations(ticket: Ticket) -> MKPointAnnotation
    {
        
            let annotation = MKPointAnnotation()
            annotation.title = ticket.venueName
            let lat = Double(ticket.latitude) ?? 0.0
            let long = Double(ticket.longitude) ?? 0.0
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: long )
            map.addAnnotation(annotation)
            return annotation
        
    }

        
    func requestNewConcerts(latLong:String, genreKey:String)
        {
            tickerCaller.request(latlong: latLong, genreKey: genreKey)
            { result in
                switch result{
                case .success(let tickets):
                    
                    for ticket in tickets
                    {
                        print(ticket.venueName)
                        print(ticket.concertName)
                        print(ticket.minPrice)
                        print(ticket.longitude)
                        print(ticket.latitude)
                        self.ticketMap[self.createAnnotations(ticket: ticket)] = ticket
                        
//                        where you will put pins
                    }
                   
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
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
            map.setRegion(region, animated: true)
        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            checkLocationAuthorization()
        }
        
    }

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation as? MKPointAnnotation else { return }
        print(ticketMap[annotation]?.concertName ?? "unknown")
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


