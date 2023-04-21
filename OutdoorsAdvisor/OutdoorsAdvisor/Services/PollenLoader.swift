//
//  PollenLoader.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/21/23.
//

import Foundation

class PollenLoader: ObservableObject {
    let apiClient: TomorrowIOAPI
    @Published private(set) var state: LoadingState = .idle
    
    init(apiClient: TomorrowIOAPI) {
        self.apiClient = apiClient
    }
    
    enum LoadingState {
        case idle
        case loading
        case success(data: PollenSummary)
        case failed(error: Error)
    }
    
    enum DataError: Error {
      case noPollen
    }
    
    @MainActor
    func loadPollen(city: City) async {
        self.state = .loading
        do {
            let response: PollenResponse = try await apiClient.fetchPollen(coordinate: city.coordinate)
            self.state = .success(data: response.data.timelines[0].intervals[0].values)
        } catch {
            self.state = .failed(error: error)
        }
    }
}
