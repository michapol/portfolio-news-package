//
//  News.swift
//  News
//
//  Created by Mike Pollard on 24/02/2025.
//

import Foundation

public protocol NewsProvider: Sendable {
    func getHeadlines(for category: NewsCategory) async throws -> [Article]
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
    public func getHeadlines(for category: NewsCategory) async throws -> [Article] {
        let data = try await dependencies.networkService.makeServiceRequest(apiKey: apiKey, service: .category(category))

        do {
            let response = try decode(data: data)
            return response.articles
        } catch {
            throw NewsServiceError.decodingFailure
        }
    }

    private func decode(data: Data) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: data)
    }
}

extension NewsService {
    public struct Dependencies: Sendable {
        let networkService: RequestData

        public static var `default`: Self {
            .init(networkService: NetworkService())
        }
    }
}
