import Foundation

class CurrentConditionsLoader: ObservableObject {
  let apiClient: WeatherAPI
  @Published private(set) var state: LoadingState = .idle

  enum LoadingState {
    case idle
    case loading
    case success(data: CurrentConditionsSummary)
    case failed(error: Error)
  }

  //can delete this if we only use temperature, but will keep in case we want more of the conditions
  struct CurrentConditionsSummary {
    var temperature: Double
  }

  enum DataError: Error {
    case noWeather
  }


  init(apiClient: WeatherAPI) {
    self.apiClient = apiClient
  }

  @MainActor
  func loadWeatherData(city: City) async {
    self.state = .loading
    do {
        let response: CurrentWeatherResponse = try await apiClient.fetchCurrent(coordinate: city.coordinate)
        let conditionsSummary = CurrentConditionsSummary(temperature: response.data.temp)
        self.state = .success(data: conditionsSummary)
    } catch {
      self.state = .failed(error: error)
    }
  }
}

