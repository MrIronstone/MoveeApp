//
//  ListCellView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 27.10.2022.
//

import SwiftUI

struct ListCellView: View {
    let title: Title
    let baseUrl = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if let safePosterPathUrl = title.posterPath {
                if let safeUrl = URL(string: "\(baseUrl)\(safePosterPathUrl)") {
                    CustomImageView(safeUrl: safeUrl)
                }
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(title.title ?? "Unknown Title")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text(title.originalTitle ?? "Unknown Original Title")
                HStack {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        if let safeDate = title.releaseDate {
                            let year = safeDate.components(separatedBy: "-")[0]
                            let month = safeDate.components(separatedBy: "-")[1]
                            let day = safeDate.components(separatedBy: "-")[2]
                            let newDate = "\(day).\(month).\(year)"
                            Text(newDate)
                        }
                    }
                    Divider().fixedSize()
                    HStack {
                        Image(systemName: "star.fill")
                        Text(String(format: "%.1f", title.voteAverage ?? 0.0 ))
                    }
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 5.0)
                    .foregroundColor(Color.white)
                    .background(.blue)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
            }
        } .contentShape(Rectangle())
    }
}

struct ListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ListCellView(title: Title.example1())
    }
}
