import CoreLocation
protocol OpenWeatherAPI {
 func fetchAirPollution(coordinate: CLLocationCoordinate2D) async throws -> AirPollutionResponse
}

struct OpenWeatherAPIClient: OpenWeatherAPI, APIClient {
 let session: URLSession = .shared

 func fetchAirPollution(coordinate: CLLocationCoordinate2D) async throws -> AirPollutionResponse {
   let path = OpenWeatherEndpoint.path(coordinate: coordinate)
   let response: AirPollutionResponse = try await performRequest(url: path)
   return response
 }
}

struct MockWeatherAPIClient: OpenWeatherAPI {
 func fetchAirPollution(coordinate: CLLocationCoordinate2D) async throws -> AirPollutionResponse {
     AirPollutionResponse.mock()
 }
}

