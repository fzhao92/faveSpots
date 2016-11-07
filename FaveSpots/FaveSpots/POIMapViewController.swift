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


protocol HandleMapSearch: class {
    
    func dropPOI(placemark: MKPlacemark)
    
}

class POIMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let store = SearchRequestDataSource.sharedInstance
    var POIPin: MKPlacemark? = nil

    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        let trackingButton = MKUserTrackingBarButtonItem()
        trackingButton.mapView = mapView

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
        let span = MKCoordinateSpanMake(ZoomValue.regular.rawValue, ZoomValue.regular.rawValue) //arbitrary span (about 2X2 miles i think)
        let region = MKCoordinateRegion(center: center, span: span)
        store.currentLocationRegion = region
        mapView.setRegion(region, animated: true)
    }

}

extension POIMapViewController: CLLocationManagerDelegate{
    
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

extension POIMapViewController: HandleMapSearch {
    
    func dropPOI(placemark: MKPlacemark) {
        //cache pin
        POIPin = placemark
        //clear existing pins if needed
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        let span = MKCoordinateSpanMake(ZoomValue.zoom.rawValue, ZoomValue.zoom.rawValue)
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
}





