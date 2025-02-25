//
//  CategoryTests.swift
//  News
//
//  Created by Mike Pollard on 24/02/2025.
//

import Testing

@testable import News

@Suite("NewsProvider Tests")
struct NewsServiceTests {
    @Test("Get headlines calls network service with correct api key and service")
    func getHeadlines() async throws {
        let testApiKey = "test_api_key"
        let category = NewsCategory.general
        let service = MockNetworkService()
        let dependencies = News.Dependencies(networkService: service)
        let newsService = News(apiKey: testApiKey, dependencies: dependencies)

        _ = try await newsService.getHeadlines(for: category)

        let expectedValues = MockNetworkService.MakeServiceRequestValues(apiKey: testApiKey, service: .category(category))
        #expect(service.makeServiceRequestValues == [expectedValues])
    }
}
