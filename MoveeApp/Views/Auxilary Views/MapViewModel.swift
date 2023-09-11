//
//  MapViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 10.09.2023.
//

import MapKit

enum MapStatics {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    static let zoomedSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject {
    var locationManager: CLLocationManager?

    @Published var selectedLandmark: Landmark?
    
    @Published var landmarks = [Landmark]()
      
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.331516,
            longitude: -121.891054
        ), span: MapStatics.defaultSpan
    )
    
    func getNearbyLandmarks() {
//        let request = MKLocalPointsOfInterestRequest(center: region.center, radius: 1000)
//        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [MKPointOfInterestCategory.theater, MKPointOfInterestCategory.movieTheater])
//        let search = MKLocalSearch(request: request)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "sinema"
        request.region = region
        let search = MKLocalSearch(request: request)
        
        DispatchQueue.main.async {
            search.start { response, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let response = response {
                    let mapItems = response.mapItems
                
                    self.landmarks = mapItems.map {
                        Landmark(mapItem: $0)
                    }
                }
            }
        }
    }
    
    func checkIfLocationServiceIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.sync {
                    self.locationManager = CLLocationManager()
                    guard let locationManager = self.locationManager else { return }
                    locationManager.delegate = self
                }
            } else {
                print("Location Service is disabled...")
            }
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Authorization is restricted. Probably due to parental control")
        case .denied:
            print("Authorization is denied. Go the settings and enable it")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let coordinate = locationManager.location else { return }
            region = MKCoordinateRegion(center: coordinate.coordinate, span: MapStatics.defaultSpan)
            self.getNearbyLandmarks()
        @unknown default:
            break
        }
    }
    
    public func requestLocation() {
        guard let locationManager else { return }
        locationManager.requestLocation()
    }
}

extension MapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(center: location.coordinate, span: MapStatics.defaultSpan)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
