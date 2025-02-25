//
//  CategoryTests.swift
//  News
//
//  Created by Mike Pollard on 24/02/2025.
//

import Foundation
import Testing

@testable import NewsService

@Suite("NewsProvider Tests")
struct NewsServiceTests {
    private let networkService = MockNetworkService()
    private let category = NewsCategory.general

    @Test("Get headlines calls network service with correct api key and service")
    func getHeadlines() async throws {
        let testApiKey = "test_api_key"
        let sut = try makeSut(json: "news-good", apiKey: testApiKey)

        _ = try await sut.getHeadlines(for: category)

        let expectedValues = MockNetworkService.MakeServiceRequestValues(apiKey: testApiKey, service: .category(category))
        #expect(networkService.makeServiceRequestValues == [expectedValues])
    }

    @Test("Get headlines correctly decodes the JSON respopnse")
    func decodeHeadlines() async throws {
        let sut = try makeSut(json: "news-good")

        let articles = try await sut.getHeadlines(for: category)

        #expect(articles == [MockArticles.news])
    }

    @Test("Get headlines throws when decoding fails")
    func failedDecodingThrows() async throws {
        let sut = try makeSut(json: "news-bad")

        await #expect(throws: NewsServiceError.decodingFailure) {
            try await sut.getHeadlines(for: category)
        }
    }

    private func makeSut(json: String, apiKey: String = "test") throws -> NewsService {
        networkService.makeServiceRequestReturnValue = try #require(Data(json: json))
        let dependencies = NewsService.Dependencies(networkService: networkService)
        let sut = NewsService(apiKey: apiKey, dependencies: dependencies)

        return sut
    }
}
