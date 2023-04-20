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
    func fetchWeatherConditions(city: String) async throws -> WeatherConditionsResponse
}

struct TomorrowIOAPIClient: TomorrowIOAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchWeatherConditions(city: String) async throws -> WeatherConditionsResponse {
        let path = TomorrowIOAPIEndpoint.path(city: city)
        let response: WeatherConditionsResponse = try await performRequest(url: path)
        return response
    }
}

struct MockTomorrowIOAPIClient: TomorrowIOAPI {
    func fetchWeatherConditions(city: String) async throws -> WeatherConditionsResponse {
        WeatherConditionsResponse.mock()
    }
}
