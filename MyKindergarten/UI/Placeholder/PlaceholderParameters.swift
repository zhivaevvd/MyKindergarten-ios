//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation
import UIKit

public struct PlaceholderParameters {
    // MARK: Lifecycle

    public init(
        title: String,
        description: String?,
        image: UIImage?,
        button: Button?,
        layout: PlaceholderLayout,
        imageSize: ImageSize = .large,
        fullScreen: Bool = true
    ) {
        self.title = title
        self.description = description
        self.image = image
        self.button = button
        self.layout = layout
        self.imageSize = imageSize
        self.fullScreen = fullScreen
    }

    // MARK: Public

    public struct Button {
        // MARK: Lifecycle

        public init(title: String, action: (() -> Void)?) {
            self.title = title
            self.action = action
        }

        // MARK: Public

        public let title: String
        public let action: (() -> Void)?
    }

    public enum PlaceholderLayout {
        case `default`
        case custom(layoutBuilder: ((UIView) -> Void)?)
    }

    public enum ImageSize: CGFloat {
        case large = 160
        case small = 64
    }

    public let title: String
    public let description: String?
    public let image: UIImage?
    public let imageSize: ImageSize
    public let button: Button?
    public let layout: PlaceholderLayout
    public let fullScreen: Bool

    public func withLayout(_ layout: PlaceholderLayout) -> PlaceholderParameters {
        PlaceholderParameters(
            title: title,
            description: description,
            image: image,
            button: button,
            layout: layout,
            imageSize: imageSize,
            fullScreen: fullScreen
        )
    }
}
