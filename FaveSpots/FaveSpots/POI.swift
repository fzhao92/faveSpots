//
//  File.swift
//  FaveSpots
//
//  Created by Forrest Zhao on 11/5/16.
//  Copyright © 2016 ForrestApps. All rights reserved.
//
import CoreLocation


protocol LocationDetails {
    
    var name: String { get set }
    
    var comments: String { get set }
    
    var rating: Rating { get set }
    
    var distanceFromCurrent: Int { get set }
    
}

struct POI: LocationDetails {
    
    internal var distanceFromCurrent: Int

    internal var rating: Rating

    internal var comments: String

    internal var name: String

}

enum Rating {
    
    case one, two, three, four, five
    
    var rawValue: Int {
        switch self {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        }
    }
}
