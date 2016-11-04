//
//  ViewController.swift
//  FaveSpots
//
//  Created by Forrest Zhao on 11/4/16.
//  Copyright © 2016 ForrestApps. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let store = SearchRequestDataSource.sharedInstance
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager {
            centerMapOnCurrentLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapOnCurrentLocation() {
        let center = CLLocationCoordinate2D(latitude: store.currentLocation.coordinate.latitude, longitude: store.currentLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.02, 0.02) //arbitrary span (about 2X2 miles i think)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }

}

extension ViewController: CLLocationManagerDelegate{
    
    func setupLocationManager(completion: () -> Void){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        if let unwrappedLocation = locationManager.location{
            store.currentLocation = unwrappedLocation
        }
        
        completion()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let unwrappedLocation = manager.location{
            store.currentLocation = unwrappedLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}




