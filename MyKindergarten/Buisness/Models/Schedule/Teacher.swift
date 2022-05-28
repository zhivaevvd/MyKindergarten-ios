//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct Teacher: Decodable {
    public let name: String
    public let photos: [Photo]
    public let position: String
    public let experience: Int
    public let attestation: String
    public let education: String
    public let advancedTraining: String
    public let achievments: [Achievments]?
    public let profRetraining: [Achievments]?
}
