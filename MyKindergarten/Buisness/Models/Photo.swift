//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct Photo: Decodable, Equatable, Hashable {
    public let id: String
    public let url: String?
}
