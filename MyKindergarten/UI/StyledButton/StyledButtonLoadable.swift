//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public protocol StyledButtonLoadable: AnyObject {
    func startLoading(with parameters: StyledButtonLoaderStyle)
    func stopLoadingProgress()
}
