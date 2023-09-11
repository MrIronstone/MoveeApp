//
//  Landmark.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 10.09.2023.
//

import MapKit

struct Landmark: Identifiable, Equatable {
    let mapItem: MKMapItem
    
    var id: UUID {
        UUID()
    }
    
    var name: String {
        mapItem.placemark.name ?? ""
    }
    
    var phoneNumber: String {
        mapItem.phoneNumber ?? ""
    }
    
    var description: String {
        mapItem.description
    }
    
    var title: String {
        mapItem.placemark.title ?? ""
    }
    
    var coordinate: CLLocationCoordinate2D {
        mapItem.placemark.coordinate
    }
    
    
    static func example1() -> Landmark {
        Landmark(
            mapItem: MKMapItem(
                placemark: MKPlacemark(
                    coordinate: CLLocationCoordinate2D(
                        latitude: 30,
                        longitude: 40
                    ), addressDictionary:
                        ["title": "Test",
                         "phone_number": "+912319273",
                         "name": "asdasdas"
                        ]
                )
            )
        )
    }
}
