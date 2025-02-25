//
//  NetworkRequest.swift
//  News
//
//  Created by Mike Pollard on 22/06/2024.
//

import Foundation

protocol ServiceRequestProtocol {
    var urlRequest: URLRequest { get throws }
}

struct ServiceRequest {
    private let dependencies: Dependencies

    private let category: NewsCategory
    private let httpMethod: HTTPMethod
    private let urlValues: [String: String]?

    init(
        dependencies: Dependencies = .default,
        category: NewsCategory,
        httpMethod: HTTPMethod = .GET,
        urlValues: [String: String]? = nil
    ) {
        self.dependencies = dependencies
        self.category = category
        self.httpMethod = httpMethod
        self.urlValues = urlValues
    }

    private func fetchUrl(for category: NewsCategory, with values: [String: String]?) throws -> URL {
        var urlString = dependencies.baseUrl + category.path
        if let values {
            urlString = update(url: urlString, with: values)
        }
        guard let url = URL(string: urlString) else { throw ServiceRequestError.invalidUrl }
        return url
    }

    private func update(url: String, with values: [String: String]) -> String {
        var url = url
        for (key, value) in values {
            url = url.replacingOccurrences(of: key, with: value)
        }
        return url
    }
}

extension ServiceRequest: ServiceRequestProtocol {
    var urlRequest: URLRequest {
        get throws {
            let url = try fetchUrl(for: category, with: urlValues)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = httpMethod.rawValue
            return urlRequest
        }
    }
}

extension ServiceRequestProtocol where Self == ServiceRequest {
    static func category(_ category: NewsCategory) -> Self {
        ServiceRequest(category: category)
    }
}

extension ServiceRequest {
    struct Dependencies {
        let baseUrl: String

        static var `default`: Self {
            .init(
                baseUrl: "https://newsapi.org/v2/"
            )
        }
    }
}

extension ServiceRequest: Equatable {}
extension ServiceRequest.Dependencies: Equatable {}
