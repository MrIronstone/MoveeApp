//
//  GenericListItemView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 18.08.2023.
//

import SwiftUI

struct GenericListItemView: View {
    @ObservedObject private var viewModel: GenericListItemViewModel
    
    init(viewModel: GenericListItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 10) {
            CustomImageView(path: viewModel.customImageURL)
                .frame(height: 150)
            VStack(alignment: .leading, spacing: 25) {
                Text(viewModel.contentName)
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                Text(viewModel.contentSubtitle)
                    .font(.system(size: 18))
                    .lineLimit(1)
                    .foregroundColor(.primary)
                HStack {
                    Image(systemName: viewModel.contentIcon)
                        .foregroundColor(.blue)
                    Text(viewModel.contentIconText)
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                }
                .fixedSize()
            }
            Spacer()
        }
        .background(.regularMaterial)
        .cornerRadius(10)
        .overlay {
        RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
        }
    }
}

//struct GenericListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenericListItemView()
//    }
//}
