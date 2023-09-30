//
//  ProfileView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 31.08.2023.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authentication: Authentication

    @ObservedObject var viewModel = ProfileViewModel()
    
    @ObservedObject var favoriteRepository = FavoriteList.shared
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TitleEntity.id, ascending: true)], animation: .default) var coreDataTitles: FetchedResults<TitleEntity>
    
    @State var showAlert = false
    
    // popup state
    @State var showIndicator = false


    init() {
        viewModel.getAccountDetails()
    }
    
    var body: some View {
        GeometryReader { geometryReader in
            NavigationStack {
                ScrollView {
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(.blue)
                                .frame(
                                    width: geometryReader.size.width,
                                    height: geometryReader.size.height,
                                    alignment: .top
                                )
                                .background(Color.blue)
                                .padding(EdgeInsets(top: -(geometryReader.size.height - 200), leading: 0, bottom: 0, trailing: 0))
                            
                                
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Profile")
                                        .font(.system(size: 41).bold())
                                    Spacer()
                                    Menu {
                                        Button("Logout") {
                                            showAlert.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "arrow.left.square")
                                            .foregroundColor(.white) // Adjust the color as needed
                                            .font(.system(size: 24))
                                    }
                                }
                                Spacer()
                                    .frame(height: 10)
                                Text("Hello 👋")
                                    .font(.system(size: 30))
                                Text(viewModel.accountDetails?.username ?? "N/A")
                                .font(.system(size: 32)).bold()
                            }
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 32)
                        }
                        
                        if showIndicator {
                            ProgressView()
                                .frame(
                                    width: geometryReader.size.width / 2,
                                    height: geometryReader.size.height / 2,
                                    alignment: .center
                                )
                        }
                        
                        
                        // Fav list
                        LazyVStack(alignment: .leading) {
                            Text("Favorites")
                                .font(.system(size: 22).bold())
                                .foregroundColor(.primary)
                            
                            ForEach(favoriteRepository.favList) { title in
                                if title.firstAirDate != nil {
                                    ListCellView(viewModel: ListCellViewModel(title: title, genreList: GenreResponse.example1()))
                                } else {
                                    ListCellView(viewModel: ListCellViewModel(title: title, genreList: GenreResponse.example1()))
                                }
                            }
                        }
                        .padding(.horizontal, 32)
                        
                    }
                    .alert("Options",
                           isPresented: $showAlert,
                           actions: {
                        Button("Logout") {
                            self.showIndicator.toggle()
                            self.authentication.removeAuthentication { _ in
                                self.showIndicator.toggle()
                            }
                        }
                    }, message: {
                        Text("Would you like to log out?")
                    })
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
