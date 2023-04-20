//
//  TomorrowIOAPIClient.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/14/23.
//

import Foundation
import CoreLocation

protocol TomorrowIOAPI {
    //func fetchAirConditions(coordinate: CLLocationCoordinate2D) async throws -> AirConditionsResponse
    func fetchAirConditions(city: String) async throws -> AirConditionsResponse
}

struct TomorrowIOAPIClient: TomorrowIOAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchAirConditions(city: String) async throws -> AirConditionsResponse {
        let path = TomorrowIOAPIEndpoint.path(city: city)
        let response: AirConditionsResponse = try await performRequest(url: path)
        return response
    }
}

struct MockTomorrowIOAPIClient: TomorrowIOAPI {
    func fetchAirConditions(city: String) async throws -> AirConditionsResponse {
        AirConditionsResponse.mock()
    }
}
