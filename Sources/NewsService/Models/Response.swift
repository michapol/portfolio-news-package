//
//  Response.swift
//  NewsService
//
//  Created by Mike Pollard on 27/02/2025.
//

struct Response {
    let articles: [Article]
}

extension Response: Decodable {}
