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

  struct CurrentConditionsSummary {
    var description: String
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
      if let weather = response.weathers.first {
        let conditionsSummary = CurrentConditionsSummary(description: weather.description, temperature: response.data.temp)
        self.state = .success(data: conditionsSummary)
      } else {
        self.state = .failed(error: DataError.noWeather)
      }
    } catch {
      self.state = .failed(error: error)
    }
  }
}

