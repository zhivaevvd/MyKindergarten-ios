//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Firebase

// MARK: - ScheduleService

public protocol ScheduleService: AnyObject {
    func getSchedule(completion: @escaping ((Result) -> Void))
    func getScheduleItem(group: String, week: String, id: String, completion: @escaping ((Result) -> Void))
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

    public func getScheduleItem(group: String, week: String, id: String, completion: @escaping ((Result) -> Void)) {
        let docRef = database.collection(group).document(week).collection(id).document("item")

        docRef.getDocument { snap, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }

            guard let item = try? snap?.data(as: ScheduleItem.self) else { return }
            completion(.success(item))
        }
    }

    // MARK: Private

    private let database: Firestore
}

// MARK: - ListResponse

struct ListResponse<T: Decodable>: Decodable {
    public let list: [T]
}
