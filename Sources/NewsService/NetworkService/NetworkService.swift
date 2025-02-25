//
//  Network.swift
//  News
//
//  Created by Mike Pollard on 21/06/2024.
//

import Foundation

protocol RequestData: Sendable {
    func makeServiceRequest(apiKey: String, service: ServiceRequestProtocol) async throws -> Data
}

final class NetworkService {
    private let dependencies: Dependencies

    init(dependencies: Dependencies = .default) {
        self.dependencies = dependencies
    }

    private func buildHeaders(apiKey: String) throws -> [AnyHashable : Any] {
        ["Authorization": "Bearer \(apiKey)"]
    }
}

extension NetworkService: RequestData {
    func makeServiceRequest(apiKey: String, service: ServiceRequestProtocol) async throws -> Data {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = try buildHeaders(apiKey: apiKey)

        let session = dependencies.urlSession(configuration)
        let urlRequest = try service.urlRequest

        let (data, _) = try await session.data(for: urlRequest)
        return data
    }
}

extension NetworkService {
    struct Dependencies: Sendable {
        let urlSession: @Sendable (URLSessionConfiguration) -> URLSessionProtocol

        static var `default`: Self {
            .init(
                urlSession: { configuration in URLSession(configuration: configuration) }
            )
        }
    }
}
