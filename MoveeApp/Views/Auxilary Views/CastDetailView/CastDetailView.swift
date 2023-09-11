//
//  CastDetailView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 5.08.2023.
//

import SwiftUI
import Kingfisher

struct CastDetailView: View {
    @ObservedObject private var viewModel: CastDetailViewModel
    
    init(viewModel: CastDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geoReader in
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    KFImage(URL(string: TmdbEndpoint.getImage(path: viewModel.person?.profilePath ?? "", imageRes: .lowRes).returnUrlAsString()))
                        .resizable()
                        .frame(width: geoReader.size.width, height: geoReader.size.width * 1.5)
                    VStack(alignment: .leading, spacing: 16) {
                        Text(viewModel.person?.name ?? "")
                            .font(.system(size: 32, weight: .bold))
                        Text(viewModel.person?.biography ?? "")
                            .font(.system(size: 17))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(viewModel.lineLength)
                        Button {
                            viewModel.toggleBioLength()
                        } label: {
                            Text(viewModel.expandCollapseButtonText)
                        }
                        HStack {
                            Text("Born: ")
                                .font(.system(size: 17, weight: .bold))
                            Text(viewModel.person?.placeOfBirth ?? "not found")
                                .font(.system(size: 17))
                        }
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.titles) { title in
                                VStack {
                                    NavigationLink {
                                        DetailView(viewModel: DetailViewModel(title: title, genreList: .example1()))
                                    } label: {
                                        CardCellView(viewModel: CardCellViewModel(title: title, genreList: .example1()))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 32)
                    .navigationBarTitleDisplayMode(.inline)
                }
                .onAppear {
                    viewModel.fetchCastDetails(castId: viewModel.person?.id ?? 0)
                }
            }
        }
    }
}

struct CastDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CastDetailView(viewModel: CastDetailViewModel(person: Person.example1()))
    }
}
