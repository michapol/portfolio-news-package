//
//  ServiceRequestError.swift
//  News
//
//  Created by Mike Pollard on 23/06/2024.
//

import Foundation

enum ServiceRequestError: LocalizedError {
    case invalidUrl

    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "The service URL is invalid"
        }
    }
}
