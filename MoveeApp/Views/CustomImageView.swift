//
//  CustomImageView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 28.10.2022.
//

import SwiftUI
import Kingfisher

enum ImageRes {
    case lowRes
    case highRes
}

struct CustomImageView: View {
    let imageRes: ImageRes
    let path: String?    
    
    init(path: String?, imageRes: ImageRes = .lowRes) {
        self.imageRes = imageRes
        self.path = path
    }
    
    var body: some View {
        if let safePath = path {
            if let safeUrl = URL(string: TmdbEndpoint.getImage(path: safePath, imageRes: imageRes).returnUrlAsString()) {
                KFImage(safeUrl)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
            }
        }
        
        /*
         AsyncImage(url: safeUrl ) { image in
         image.resizable()
         .scaledToFit()
         // .frame(width: (imageSize * 9) / 16, height: imageSize )
         } placeholder: {
         ProgressView()
         //  .frame(width: (imageSize * 9) / 16, height: imageSize )
         }
         */
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView(path: "/yw8NQyvbeNXoZO6v4SEXrgQ27Ll.jpg")
    }
}