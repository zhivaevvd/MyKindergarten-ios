//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct Sender: Decodable, RawRepresentable, Equatable, Hashable {
    // MARK: Lifecycle

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // MARK: Public

    public static let user: Sender = .init(rawValue: "user")
    public static let teacher: Sender = .init(rawValue: "teacher")

    public let rawValue: String
}
