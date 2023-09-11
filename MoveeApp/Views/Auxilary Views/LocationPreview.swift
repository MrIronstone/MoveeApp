//
//  LocationPreview.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 10.09.2023.
//

import SwiftUI
import MapKit

struct LocationPreview: View {
    let landmark: Landmark
    
    let closeButton: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                closeButton()
            } label: {
                Image(systemName: "xmark.app.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            if let name = landmark.mapItem.name,
               let phoneNumber = landmark.mapItem.phoneNumber {
            Text(name)
                .font(.system(size: 30))
            Text(phoneNumber)
                .font(.system(size: 24))
            }
            Button {
                let coordinate = landmark.mapItem.placemark.coordinate
                guard let url = URL(string: "http://maps.apple.com/?daddr=\(coordinate.latitude),\(coordinate.longitude)") else { return }
                UIApplication.shared.open(url)
            } label: {
                Text("Get route")
                    .font(.system(size: 18))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .frame(width: 300, height: 150)
        .background(.gray)
        .cornerRadius(20)
    }
}

struct LocationPreview_Previews: PreviewProvider {
    static var previews: some View {
        LocationPreview(landmark: Landmark.example1()) {
            print("exited")
        }
    }
}
