import Foundation
import CoreLocation

struct OpenWeatherEndpoint {
  static let baseUrl = "https://api.openweatherMap.org/data/2.5"
  static let apiKey = "9dd0bd7e51ca5fd907993c6325af3a68"

  enum QueryType: String {
    case forecast
    case current = "weather"
  }

  static func path(queryType: QueryType, coordinate: CLLocationCoordinate2D) -> String {
    let url = "\(baseUrl)/\(queryType.rawValue)"
    let key = "appid=\(apiKey)"
    let units = "units=imperial"
    let queryParameters = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
    return "\(url)?\(units)&\(queryParameters)&\(key)"
  }
}


