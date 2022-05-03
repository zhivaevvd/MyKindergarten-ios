//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation

@available(iOS 13.0, *)
public extension Publisher {
    func drive(_ binding: @escaping (Self.Output) -> Void) -> AnyCancellable {
        receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (_: Subscribers.Completion<Failure>) in

            }, receiveValue: { output in
                binding(output)
            })
    }

    func subscribe(_ binding: @escaping (Self.Output) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { (_: Subscribers.Completion<Failure>) in

        }, receiveValue: { output in
            binding(output)
        })
    }
}
