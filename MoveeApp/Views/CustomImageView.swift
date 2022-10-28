//
//  CustomImageView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 28.10.2022.
//

import SwiftUI

struct CustomImageView: View {
    var safeUrl: URL
    
    let imageSize: CGFloat = 100
    
    var body: some View {
        AsyncImage(url: safeUrl ) { image in
            image.resizable()
                .scaledToFill()
                .frame(width: (imageSize * 16) / 9, height: imageSize)
        } placeholder: {
            ProgressView()
                .frame(width: 100, height: 100)
        }
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        if let safeUrl = URL(string: "https://image.tmdb.org/t/p/w500/yw8NQyvbeNXoZO6v4SEXrgQ27Ll.jpg") {
            CustomImageView(safeUrl: safeUrl)
        }
    }
}
