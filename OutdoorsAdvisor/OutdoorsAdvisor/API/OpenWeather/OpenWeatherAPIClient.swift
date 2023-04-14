import CoreLocation
protocol WeatherAPI {
 func fetchCurrent(coordinate: CLLocationCoordinate2D) async throws -> CurrentWeatherResponse
}

struct WeatherAPIClient: WeatherAPI, APIClient {
 let session: URLSession = .shared

 func fetchCurrent(coordinate: CLLocationCoordinate2D) async throws -> CurrentWeatherResponse {
   let path = OpenWeatherEndpoint.path(coordinate: coordinate)
   let response: CurrentWeatherResponse = try await performRequest(url: path)
   return response
 }
}

struct MockWeatherAPIClient: WeatherAPI {
 func fetchCurrent(coordinate: CLLocationCoordinate2D) async throws -> CurrentWeatherResponse {
   CurrentWeatherResponse.mock()
 }
}

