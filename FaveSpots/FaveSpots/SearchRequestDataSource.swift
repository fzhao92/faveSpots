//
//  SearchRequestDataSource.swift
//  FaveSpots
//
//  Created by Forrest Zhao on 11/4/16.
//  Copyright © 2016 ForrestApps. All rights reserved.
//
import CoreLocation
import MapKit

class SearchRequestDataSource {
    static let sharedInstance = SearchRequestDataSource()
    private init() {}
    
    //var searchRequests: [MKLocalSearchRequest] = []
    var searchHistory: [String] = []
    var currentSearchResults: [MKMapItem] = []
    var currentLocation = CLLocation()
    var currentLocationRegion: MKCoordinateRegion?
    
    func searchFor(placeRelatedTerm term: String) {
        SearchResults.search(forPlaceQueryTerm: term, region: currentLocationRegion!) { (searchResultItems) in
            self.currentSearchResults = searchResultItems
            print("Number of items in result is \(self.currentSearchResults.count)")
            if self.currentSearchResults.count > 0 {
                self.searchHistory.append(term)
            }
        }
    }
}

extension MKMapItem {
    func parseAddress(selectedItem: MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}
