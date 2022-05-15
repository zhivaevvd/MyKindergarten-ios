//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct User: Decodable {
    public let name: String
    public let phone: String
    public let kindergartenAddress: String
    public let groups: [String]
    public let email: String
    public let password: String
}
