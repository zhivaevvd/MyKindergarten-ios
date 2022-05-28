//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Kingfisher
import UIKit

public extension UIImageView {
    private static var token: String = ""

    static var authenticatedResourceModifier: AnyModifier {
        AnyModifier { request in
            var r = request
            r.setValue(token, forHTTPHeaderField: "Authorization")
            return r
        }
    }

    func loadImage(url: String?) {
        guard let url = url else { return }
        kf.cancelDownloadTask()

        guard let encoded = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
              let downloadURL = URL(string: encoded)
        else { return }
        let resource = ImageResource(downloadURL: downloadURL, cacheKey: url)
        let cache = ImageCache.default

        if cache.isCached(forKey: url) {
            kf.setImage(
                with: resource,
                placeholder: image,
                options: [
                    .onlyFromCache,
                ]
            )
        } else {
            kf.setImage(
                with: resource,
                placeholder: image,
                options: [
                    .requestModifier(Self.authenticatedResourceModifier),
                    .transition(.fade(0.2)),
                    .forceTransition,
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading,
                ]
            )
        }
    }
}
