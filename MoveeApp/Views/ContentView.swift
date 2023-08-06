//
//  ContentView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 23.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                MoviesView()
                    .tabItem {
                        Image(systemName: "film")
                        Text("Movies")
                    }
                TvSeriesView()
                    .tabItem {
                        Image(systemName: "tv")
                        Text("TV Series")
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
