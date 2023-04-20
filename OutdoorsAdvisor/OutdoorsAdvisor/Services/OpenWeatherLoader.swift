import Foundation

class OpenWeatherLoader: ObservableObject {
  let apiClient: OpenWeatherAPI
  @Published private(set) var state: LoadingState = .idle

  enum LoadingState {
    case idle
    case loading
    case success(data: AirPollutionSummary)
    case failed(error: Error)
  }

  struct AirPollutionSummary {
    var airQualityIndex: Double
  }

  enum DataError: Error {
    case noWeather
  }


  init(apiClient: OpenWeatherAPI) {
    self.apiClient = apiClient
  }

  @MainActor
  func loadAirData(city: City) async {
    self.state = .loading
    do {
        let response: AirPollutionResponse = try await apiClient.fetchAirPollution(coordinate: city.coordinate)
        let airConditionsSummary = AirPollutionSummary(airQualityIndex: response.data[0].airQualityIndexWrapper.airQualityIndex)
        self.state = .success(data: airConditionsSummary)
    } catch {
      self.state = .failed(error: error)
    }
  }
}

