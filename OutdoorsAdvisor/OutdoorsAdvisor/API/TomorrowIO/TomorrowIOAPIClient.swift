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
    func fetchPollen(coordinate: CLLocationCoordinate2D) async throws -> PollenResponse
}

struct TomorrowIOAPIClient: TomorrowIOAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchWeatherConditions(city: String) async throws -> WeatherConditionsResponse {
        let path = TomorrowIOAPIEndpoint.path(city: city, queryType: .weather)
        let response: WeatherConditionsResponse = try await performGETRequest(url: path)
        return response
    }
    //need to figure out correct format to get weatherconditions from coordinate so path isn't weird
    func fetchPollen(coordinate: CLLocationCoordinate2D) async throws -> PollenResponse {
        let path = TomorrowIOAPIEndpoint.path(city: "None", queryType: .pollen)
        let coordAsString = "\(String(format: "%.4f", coordinate.latitude)), \(String(format: "%.4f", coordinate.longitude))"
        let body: [String: Any] = [
            "location": coordAsString,
            "fields": ["grassIndex", "treeIndex"],
            "units": "metric",
            "timesteps": ["1h"],
            "startTime": "now",
            "endTime": "nowPlus1h"
        ]
        
        let bodyData = try? JSONSerialization.data(withJSONObject: body, options: [])
        let response: PollenResponse = try await performPOSTRequest(url: path, body: bodyData)
        return response
    }
}

struct MockTomorrowIOAPIClient: TomorrowIOAPI {
    func fetchWeatherConditions(city: String) async throws -> WeatherConditionsResponse {
        WeatherConditionsResponse.mock()
    }
    func fetchPollen(coordinate: CLLocationCoordinate2D) async throws -> PollenResponse {
        PollenResponse.mock()
    }
}
