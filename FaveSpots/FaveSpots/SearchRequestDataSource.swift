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
    
    var searchRequests: [MKLocalSearchRequest] = []
    var currentSearchResults: [MKMapItem] = []
    var currentLocation = CLLocation()
    var currentLocationRegion: MKCoordinateRegion?
    
    func searchForTerm(term: String) {
        SearchResults.search(forPlaceQueryTerm: term, region: currentLocationRegion!) { (searchResultItems) in
            self.currentSearchResults = searchResultItems
        }
    }
}
