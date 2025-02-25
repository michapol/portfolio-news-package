//
//  MockNetworkService.swift
//  News
//
//  Created by Mike Pollard on 24/02/2025.
//

import Foundation

@testable import News

final class MockNetworkService: RequestData {
    // MARK: - makeServiceRequest

    var makeServiceRequestValues = [MakeServiceRequestValues]()
    var makeServiceRequestReturnValue = Data()

    func makeServiceRequest(apiKey: String, service: any ServiceRequestProtocol) async throws -> Data {
        makeServiceRequestValues.append(.init(apiKey: apiKey, service: service as! ServiceRequest))
        return makeServiceRequestReturnValue
    }
}

extension MockNetworkService {
    struct MakeServiceRequestValues: Equatable {
        let apiKey: String
        let service: ServiceRequest
    }
}
