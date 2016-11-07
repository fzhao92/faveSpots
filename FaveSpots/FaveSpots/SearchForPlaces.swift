//
//  SearchForPlaces.swift
//  FaveSpots
//
//  Created by Forrest Zhao on 11/4/16.
//  Copyright © 2016 ForrestApps. All rights reserved.
//


protocol Search {
    
    static func search(forPlaceQueryTerm term: String, region: MKCoordinateRegion, completion: @escaping ([MKMapItem]) -> Void)
    
}

import MapKit

struct SearchResults: Search {
    
    static func search(forPlaceQueryTerm term: String, region: MKCoordinateRegion, completion: @escaping ([MKMapItem]) -> Void) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = term
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let unwrappedResponse = response else {
                print("There was an error searching for: \(request.naturalLanguageQuery)... \(error?.localizedDescription)")
                return
            }
            for item in unwrappedResponse.mapItems {
                print(item.name)
            }
            completion(unwrappedResponse.mapItems)
        }
    }
    
}
