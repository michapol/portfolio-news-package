//
//  Data+Init.swift
//  NewsService
//
//  Created by Mike Pollard on 25/02/2025.
//

import Foundation

extension Data {
    init?(json: String) {
        guard let file = Bundle.module.url(forResource: json, withExtension: "json") else { return nil }
        try? self.init(contentsOf: file)
    }
}
