//
//  Article.swift
//  NewsService
//
//  Created by Mike Pollard on 25/02/2025.
//

import Foundation

public struct Article {
    public let author: String?
    public let title: String
    public let description: String?
    public let publishedAt: Date
    public let urlToImage: URL?
}

extension Article: Equatable {}
extension Article: Decodable {}
extension Article: Sendable {}
