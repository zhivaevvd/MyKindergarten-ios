//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Firebase

// MARK: - ScheduleService

public protocol ScheduleService: AnyObject {
    func getSchedule(completion: @escaping ((Result) -> Void))
}

// MARK: - SheduleServiceImpl

public final class SheduleServiceImpl: ScheduleService {
    // MARK: Lifecycle

    public init() {
        database = Firestore.firestore()
    }

    // MARK: Public

    public func getSchedule(completion: @escaping ((Result) -> Void)) {
        let docRef = database.collection("Schedule").document("ScheduleList")

        docRef.getDocument { result, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            let list = try? result?.data(as: ListResponse<Schedule>.self)
            completion(.success(list?.list ?? []))
        }
    }

    // MARK: Private

    private let database: Firestore
}

// MARK: - ListResponse

struct ListResponse<T: Decodable>: Decodable {
    public let list: [T]
}
