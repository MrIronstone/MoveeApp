//
//  GenericListItemViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 18.08.2023.
//

import Foundation

class GenericListItemViewModel: ObservableObject {
    var contentName: String
    var customImageURL: String
    var contentSubtitle: String
    var contentIcon: String
    var contentIconText: String

    init(contentName: String, customImageURL: String, contentSubtitle: String, contentIcon: String, contentIconText: String) {
        self.contentName = contentName
        self.customImageURL = customImageURL
        self.contentSubtitle = contentSubtitle
        self.contentIcon = contentIcon
        self.contentIconText = contentIconText
    }
}
