//
//  DetailView.swift
//  MoveeApp
//
//  Created by admin on 29.10.2022.
//

import SwiftUI
import Kingfisher

enum TitleType {
    case tvSeries
    case movie
}

struct DetailView: View {
    @ObservedObject private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader(content: { geoReader in
            ScrollView {
                CustomImageView(path: viewModel.title.backdropPath ?? viewModel.title.posterPath ?? "", imageRes: .lowRes, imageScale: .scaleToFill)
                    .frame(width: geoReader.size.width, height: ((geoReader.size.width) / 36) * 41)
                    .clipped()
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "star.fill")
                            Text(viewModel.title.getVoteAverage())
                        }
                        .padding(.horizontal, 10.0)
                        .padding(.vertical, 5.0)
                        .foregroundColor(Color.white)
                        .background(.blue)
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: -25, leading: 0, bottom: 0, trailing: 0))
                        
                        Text(viewModel.title.getTitleName())
                            .font(.system(size: 34, weight: .bold))
                        Text(viewModel.title.getGenreString(with: viewModel.genreList))
                        HStack {
                            HStack {
                                Image(systemName: "clock")
                                    .foregroundColor(.blue)
                                Text(viewModel.title.getDuration())
                                    .font(.system(size: 18))
                            }
                            .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                            Divider().fixedSize()
                            HStack {
                                Image(systemName: "calendar")
                                    .foregroundColor(.blue)
                                Text(viewModel.title.getNewDateStyle())
                                    .font(.system(size: 18))
                            }
                        }
                    }
                    Divider()
                    Text(viewModel.title.overview ?? "")
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if viewModel.titleType == .tvSeries {
                        HStack {
                            Text("\(viewModel.title.lastEpisodeToAir?.seasonNumber ?? 0) seasons")
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal, 10.0)
                        .padding(.vertical, 5.0)
                        .foregroundColor(Color.white)
                        .background(Color(UIColor.darkGray))
                        .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                        if !viewModel.title.getCreatorList().isEmpty {
                            HStack {
                                Text("Creators: ")
                                Text("\(viewModel.title.getCreatorList())")
                                    .foregroundColor(.blue)
                            }
                        }
                    } else {
                        HStack {
                            Text("Director: ")
                            Text(viewModel.director ?? "No found")
                                .foregroundColor(.blue)
                        }
                        if !(viewModel.writers?.isEmpty ?? true) {
                            HStack {
                                Text("Writers: ")
                                Text(viewModel.writers ?? "No found")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 4) {
                            ForEach(viewModel.cast) { cast in
                                NavigationLink {
                                    CastDetailView(viewModel: CastDetailViewModel(person: cast))
                                } label: {
                                    VStack(spacing: 10) {
                                        KFImage(URL(string: TmdbEndpoint.getImage(path: cast.profilePath ?? "", imageRes: .lowRes).returnUrlAsString()))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geoReader.size.width / 5, height: geoReader.size.width / 5)
                                            .cornerRadius(geoReader.size.width / 5)
                                            .padding(.horizontal, 15)
                                        Text(cast.name ?? "not found")
                                    }
                                }
                                .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                .navigationBarTitleDisplayMode(.inline)
            }
        })
        .onAppear {
            viewModel.fetchTitleDetails()
            viewModel.fetchDirectorAndWriter()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(title: Title.example2(), genreList: GenreResponse.example1()))
    }
}