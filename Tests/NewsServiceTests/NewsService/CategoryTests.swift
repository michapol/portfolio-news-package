//
//  CategoryTests.swift
//  News
//
//  Created by Mike Pollard on 24/02/2025.
//

import Testing

@testable import NewsService

@Suite("Category Tests")
struct CategoryTests {
    @Test("Tests category path returns the correct values", arguments: NewsCategory.allCases)
    func categoryPath(_ category: NewsCategory) async throws {
        #expect(category.path == "top-headlines?category=\(category.rawValue)")
    }
}
