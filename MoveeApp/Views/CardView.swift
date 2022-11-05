//
//  CardView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 5.11.2022.
//

import SwiftUI

struct CardView: View {
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.titles) { title in
                    CardViewCell(title: title)
                }
            }
        }
    }
}

struct CardViewCell: View {
    var title: Title
    
    var body: some View {
        VStack {
            CustomImageView(path: title.posterPath, imageRes: .lowRes)
                .frame(height: 400)
            Text(title.getTitleName())
            Text(title.getVoteAverage())
            Text(title.getNewDateStyle())
        }
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

struct CardViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CardViewCell(title: Title.example1())
    }
}
