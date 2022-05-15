//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct Group: RawRepresentable, Decodable, Hashable {
    // MARK: Lifecycle

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    // MARK: Public

    public static let fistJunior: Group = .init(rawValue: "firstJunior")
    public static let secondJunior: Group = .init(rawValue: "secondJunior")
    public static let middle: Group = .init(rawValue: "middle")
    public static let senior: Group = .init(rawValue: "senior")
    public static let preparatory: Group = .init(rawValue: "preparatory")

    public let rawValue: String
}
