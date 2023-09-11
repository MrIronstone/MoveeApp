//
//  ContentView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 23.10.2022.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 3
    
    var body: some View {
        TabView(selection: $selection) {
            MoviesView()
                .tag(0)
                .tabItem {
                    Image(systemName: "film")
                    Text("Movies")
                }
            TvSeriesView()
                .tag(1)
                .tabItem {
                    Image(systemName: "tv")
                    Text("TV Series")
                }
            SearchView()
                .tag(2)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            ProfileView()
                .tag(3)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .onAppear {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            // correct the transparency bug for Navigation bars
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
