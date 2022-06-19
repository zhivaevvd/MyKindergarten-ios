//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Combine
import Foundation

// MARK: - ChatViewModel

public protocol ChatViewModel: AnyObject {
    var dataSource: AnyPublisher<[Chat], Never> { get }
}

// MARK: - ChatVM

public final class ChatVM: ChatViewModel {
    // MARK: Lifecycle

    public init() {
        let chat1 = Chat(text: "На этой неделе мы не будем присутствовать( Задания к исполнению приняли", sender: .user)
        let chat2 = Chat(text: "Хорошо", sender: .teacher)
        _dataSource = [chat1, chat2]
    }

    // MARK: Public

    public var dataSource: AnyPublisher<[Chat], Never> {
        $_dataSource.eraseToAnyPublisher()
    }

    // MARK: Private

    @Published
    private var _dataSource: [Chat] = []
}
