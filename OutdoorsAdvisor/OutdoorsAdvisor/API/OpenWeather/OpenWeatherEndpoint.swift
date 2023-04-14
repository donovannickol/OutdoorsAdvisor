import Foundation
import CoreLocation

struct OpenWeatherEndpoint {
  static let baseUrl = "https://api.openweatherMap.org/data/2.5"
  static let apiKey = "24c3e1fbecc7904e8ae023cff8033b66"

  static func path(coordinate: CLLocationCoordinate2D) -> String {
    let url = "\(baseUrl)/weather"
    let key = "appid=\(apiKey)"
    let units = "units=imperial"
    let queryParameters = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
    return "\(url)?\(units)&\(queryParameters)&\(key)"
  }
}


