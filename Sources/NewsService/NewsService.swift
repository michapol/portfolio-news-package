//
//  News.swift
//  News
//
//  Created by Mike Pollard on 24/02/2025.
//

import Foundation

public protocol NewsProvider {
    func getHeadlines(for category: NewsCategory) async throws -> Data
}

public struct NewsService {
    private let apiKey: String
    private let dependencies: Dependencies

    public init(apiKey: String, dependencies: Dependencies = .default) {
        self.apiKey = apiKey
        self.dependencies = dependencies
    }
}

extension NewsService: NewsProvider {
    public func getHeadlines(for category: NewsCategory) async throws -> Data {
        try await dependencies.networkService.makeServiceRequest(apiKey: apiKey, service: .category(category))
    }
}

extension NewsService {
    public struct Dependencies {
        let networkService: RequestData

        public static var `default`: Self {
            .init(networkService: NetworkService())
        }
    }
}
