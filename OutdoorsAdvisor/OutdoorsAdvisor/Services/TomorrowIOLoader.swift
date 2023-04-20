//
//  TomorrowIOLoader.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/14/23.
//

import Foundation

class TomorrowIOLoader: ObservableObject {
    let apiClient: TomorrowIOAPI
    @Published private(set) var state: LoadingState = .idle
    
    init(apiClient: TomorrowIOAPI) {
        self.apiClient = apiClient
    }
    
    enum LoadingState {
        case idle
        case loading
        case success(data: WeatherDataValues)
        case failed(error: Error)
    }
    
    struct WeatherConditionsSummary {
        var uvIndex: Int
        var rainAmount: Double
        var rainProbability: Double
        var temperature: Double
        var humidity: Double
        var wind: Double
    }
    
    enum DataError: Error {
      case noWeatherData
    }
    
    @MainActor
    func loadWeatherConditions(city: City) async {
        self.state = .loading
        do {
            let response: WeatherConditionsResponse = try await apiClient.fetchWeatherConditions(city: city.name)
            self.state = .success(data: response.data.values)
        } catch {
            self.state = .failed(error: error)
        }
    }
}
