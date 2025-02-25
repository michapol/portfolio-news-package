//
//  URLSession+Extension.swift
//  RoundUp
//
//  Created by Mike Pollard on 23/06/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(
        for request: URLRequest
    ) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
