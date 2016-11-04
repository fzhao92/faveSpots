//
//  SearchForPlaces.swift
//  FaveSpots
//
//  Created by Forrest Zhao on 11/4/16.
//  Copyright © 2016 ForrestApps. All rights reserved.
//

import MapKit

class SearchForPlaces {
    
    class func search(forPlaceQueryTerm term: String) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = term
    }
}
