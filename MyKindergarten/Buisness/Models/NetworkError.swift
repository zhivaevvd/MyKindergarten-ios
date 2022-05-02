//
// My Kindergarten
// Copyright © 2022 Vladislav Zhivaev HxH. All rights reserved.
//

import Foundation

public struct NetworkError: Error {
    // MARK: Lifecycle

    public init(
        statusCode: Int? = nil,
        errorTitle: String? = nil,
        errorMessage: String? = nil,
        fieldErrors: [String: String]? = nil
    ) {
        self.statusCode = statusCode
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.fieldErrors = fieldErrors
    }

    // MARK: Public

    public enum Kind {
        case invalidRequest
        case nonAuth
        case expAuth
        case noConnection
        case timeOut
        case invalidResponse
        case serverUnavailable
        case fieldError
        case unknown
        case serverError
        case notFound
    }

    public static let invalidRequestStatus: Int = -99999
    public static let invalidResponseStatus: Int = -99998
    public static let noConnectionStatus: Int = -99997
    public static let unavailableStatus: Int = -99996
    public static let timeOutStatus: Int = -99995
    public static let fieldErrorStatus: Int = -99994
    public static let notFoundErrorStatus: Int = 404
    public static let expAuthStatus: Int = 400
    public static let serverErrorStatus: Int = 500

    public static let invalidRequest = NetworkError(statusCode: Self.invalidRequestStatus)
    public static let invalidResponse = NetworkError(statusCode: Self.invalidResponseStatus)
    public static let noConnection = NetworkError(statusCode: Self.noConnectionStatus)
    public static let serverUnavailable = NetworkError(statusCode: Self.unavailableStatus)
    public static let timedOut = NetworkError(statusCode: Self.timeOutStatus)
    public static let notFound = NetworkError(statusCode: Self.notFoundErrorStatus)
    public static let expAuth = NetworkError(statusCode: Self.expAuthStatus)
    public static let unknown = NetworkError(statusCode: nil)
    public static let serverError = NetworkError(statusCode: Self.serverErrorStatus)

    public var statusCode: Int?
    public var errorTitle: String?
    public var errorMessage: String?
    public var fieldErrors: [String: String]?
}
