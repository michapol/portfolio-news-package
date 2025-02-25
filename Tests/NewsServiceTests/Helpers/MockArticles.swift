//
//  MockArticles.swift
//  NewsService
//
//  Created by Mike Pollard on 25/02/2025.
//

import Foundation
@testable import NewsService

enum MockArticles {
    static let news = Article(
        author: "Jess Weatherbed",
        title: "Apple’s iPhone 17 lineup is looking a little Pixelated - The Verge",
        description: "Leaked CAD renders of what are purported to be the iPhone 17, 17 Pro, 17 Pro Max, and 17 Air — feature a Pixel-like rectangular camera bar.",
        publishedAt: (try? Date("2025-02-24T13:40:37Z", strategy: .iso8601)) ?? .distantFuture,
        urlToImage: URL(string: "https://platform.theverge.com/wp-content/uploads/sites/2/2025/02/Majin-Bu-iphone-17-cad-renders.jpg?quality=90&strip=all&crop=0%2C10.732984293194%2C100%2C78.534031413613&w=1200")!
    )
}
