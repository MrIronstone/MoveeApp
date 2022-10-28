//
//  ButtonAndResultView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.titles) { row in
                    NavigationLink {
                        Text(row.title ?? "")
                    } label: {
                        ListCellView(title: row)
                            .frame(height: 100)
                    }
                }
            } .navigationTitle("Popular Movies")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
