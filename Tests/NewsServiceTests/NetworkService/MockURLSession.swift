//
//  MockURLSession.swift
//  News
//
//  Created by Mike Pollard on 25/02/2025.
//

import Foundation

@testable import News

final class MockURLSession: URLSessionProtocol {
    // MARK: - Configuration

    var configurationValue = [URLSessionConfiguration]()

    // MARK: - URLSessionProtocol

    var dataValues = [URLRequest]()
    var dataReturnValues: (Data, URLResponse) = (Data(), URLResponse())
    var dataError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataValues.append(request)
        if let dataError {
            throw dataError
        }
        return dataReturnValues
    }
}
