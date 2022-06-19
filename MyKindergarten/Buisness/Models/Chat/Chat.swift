//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct Chat: Decodable, Hashable {
    // MARK: Lifecycle

    public init(text: String, sender: Sender) {
        self.text = text
        self.sender = sender
    }

    // MARK: Public

    public let text: String
    public let sender: Sender
}
