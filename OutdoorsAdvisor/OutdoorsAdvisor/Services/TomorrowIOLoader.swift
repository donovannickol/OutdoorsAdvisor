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
        case success(data: AirDataValues)
        case failed(error: Error)
    }
    
    enum DataError: Error {
      case noAirData
    }
    
    @MainActor
    func loadAirConditions(city: City) async {
        self.state = .loading
        do {
            let response: AirConditionsResponse = try await apiClient.fetchAirConditions(city: city.name)
            self.state = .success(data: response.data.values)
        } catch {
            self.state = .failed(error: error)
        }
    }
}
