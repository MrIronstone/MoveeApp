//
//  ButtonAndResultView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import SwiftUI

struct ButtonAndResultView: View {
    @State var titles = ""
    
    var body: some View {
        VStack {
            Text("To Get Popular Movies List, \nClick the button below")
            Button {
                NetworkEngine.request(endpoint: TmdbEndpoint.getPopularMovies) { (result: Result<TitlesResponse, Error>) in
                    switch result {
                    case .success(let success):
                        titles = ""
                        for title in success.results {
                            guard let safeTitle = title.title else { return }
                            titles += "\(safeTitle)\n"
                        }
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            } label: {
                Label("Get Request", systemImage: "arrow.down.app.fill")
            } .buttonStyle(.borderedProminent)
            Text(titles)
            Button {
                titles = ""
            } label: {
                Text("Reset")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ButtonAndResultView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAndResultView()
    }
}
