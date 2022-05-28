//
//  PlaceholderParameters+Default.swift
//  MyKindergarten
//
//  Created by Headdds and hands on 29.05.2022.
//

import Foundation

public extension PlaceholderParameters {
    static func noInternetPlaceholder(_ buttonAction: (() -> Void)?) -> PlaceholderParameters {
        PlaceholderParameters(
            title: L10n.Common.NetworkError.NoInternet.title,
            description: L10n.Common.NetworkError.NoInternet.description,
            image: Asset.iconEmptyPlaceholder.image,
            button: PlaceholderParameters.Button(title: L10n.Common.refresh, action: buttonAction),
            layout: .default
        )
    }
    
    static func unknownErrorPlaceholder(_ buttonAction: (() -> Void)?) -> PlaceholderParameters {
        PlaceholderParameters(
            title: L10n.Common.NetworkError.Unknown.title,
            description: nil,
            image: Asset.iconEmptyPlaceholder.image,
            button: PlaceholderParameters.Button(title: L10n.Common.refresh, action: buttonAction),
            layout: .default
        )
    }
}
