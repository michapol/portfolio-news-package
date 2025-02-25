//
//  Article.swift
//  NewsService
//
//  Created by Mike Pollard on 25/02/2025.
//

import Foundation

struct Response: Decodable {
    let articles: [Article]
}

public struct Article {
    let author: String?
    let title: String
    let description: String?
    let publishedAt: Date
    let urlToImage: URL?
}

extension Article: Equatable {}
extension Article: Decodable {}
extension Article: Sendable {}
