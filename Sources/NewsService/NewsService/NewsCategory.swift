//
//  ServiceUrl.swift
//  News
//
//  Created by Mike Pollard on 23/06/2024.
//

import Foundation

public enum NewsCategory: String {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}

extension NewsCategory {
    var path: String {
        "top-headlines?category=\(self.rawValue)"
    }
}

extension NewsCategory: CaseIterable {}
extension NewsCategory: Sendable {}
