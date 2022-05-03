//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public protocol UILoadable: AnyObject {
    func startLoading(with parameters: LoaderParameters)
    func stopLoadingProgress()
}
