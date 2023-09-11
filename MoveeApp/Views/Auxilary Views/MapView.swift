//
//  MapView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 9.09.2023.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct MapView: View {
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Map(
                coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                userTrackingMode: .constant(.follow),
                annotationItems: viewModel.landmarks,
                annotationContent: { landmark in
                    MapAnnotation(coordinate: landmark.coordinate) {
                        VStack {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                            Text(landmark.name)
                                .foregroundColor(.red)
                        }
                        .onTapGesture {
                            withAnimation {
                                viewModel.region = MKCoordinateRegion(center: landmark.coordinate, span: MapStatics.zoomedSpan)
                                viewModel.selectedLandmark = landmark
                            }
                        }
                    }
                }
            )
            .ignoresSafeArea()
            .onAppear {
                viewModel.checkIfLocationServiceIsEnabled()
            }
            
            ZStack {
                ForEach(viewModel.landmarks) { landmark in
                    if viewModel.selectedLandmark == landmark {
                        LocationPreview(landmark: landmark) {
                            viewModel.selectedLandmark = nil
                        }
                    }
                }
            }
            .padding(.bottom, 100)
            
            LocationButton(.currentLocation) {
                viewModel.requestLocation()
            }
            .foregroundColor(.white)
            .cornerRadius(8)
            .labelStyle(.titleAndIcon)
            .symbolVariant(.fill)
            .padding(.bottom, 20)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
