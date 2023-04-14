//
//  TomorrowIOAPIClient.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/14/23.
//

import Foundation
import CoreLocation

protocol TomorrowIOAPI {
    func fetchAirConditions(coordinate: CLLocationCoordinate2D) async throws -> AirConditionsResponse
}

struct TomorrowIOAPIClient: TomorrowIOAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchAirConditions(coordinate: CLLocationCoordinate2D) async throws -> AirConditionsResponse {
        let path = TomorrowIOAPIEndpoint.path(coordinate: coordinate)
        let response: AirConditionsResponse = try await performRequest(url: path)
        return response
    }
}
