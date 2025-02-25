//
//  NetworkServiceTests.swift
//  News
//
//  Created by Mike Pollard on 25/02/2025.
//

import Foundation
import Testing

@testable import NewsService

@Suite("Network Service Tests")
struct NetworkServiceTests {
    var sut: NetworkService!

    let urlSession = MockURLSession()
    lazy var urlSessionClosure: @Sendable (URLSessionConfiguration) -> URLSessionProtocol = { [weak urlSession] configuration in
        urlSession!.configurationValue.append(configuration)
        return urlSession!
    }

    init() {
        let dependencies = NetworkService.Dependencies(urlSession: urlSessionClosure)
        sut = NetworkService(dependencies: dependencies)
    }

    @Test("Make service request adds authorization header")
    func authHeader() async throws {
        let testApiKey = "test_api_key_648429"

        _ = try await sut.makeServiceRequest(apiKey: testApiKey, service: .category(.general))

        let headers = try #require(urlSession.configurationValue.first)
        #expect(headers.httpAdditionalHeaders?["Authorization"] as? String == "Bearer \(testApiKey)")
    }

    @Test("Make service request passes correct URLRequest to URLSession", arguments: NewsCategory.allCases)
    func urlRequest(category: NewsCategory) async throws {
        let serviceRequest: ServiceRequest = .category(category)

        _ = try await sut.makeServiceRequest(apiKey: "test", service: serviceRequest)

        #expect(urlSession.dataValues.map(\.url?.absoluteString) == ["https://newsapi.org/v2/" + category.path])
    }
}
