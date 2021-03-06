//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct ScheduleItem: Decodable {
    public let weekTheme: String
    public let title: String
    public let description: String
    public let group: String
    public let week: String
    public let tasks: [Task]
    public let teacher: Teacher
}
