import Foundation
import CoreLocation

public struct CurrentWeatherResponse: Decodable {
  var coordinate: Coordinate
  var data: TemperatureData

  // There are some keys like dt, sys, base, etc. that I don't want to deal with
  // So I will put just the keys I want here and rename some I like the least
  private enum CodingKeys: String, CodingKey {
    case coordinate = "coord"
    case data = "main"
  }

  static func mock() -> CurrentWeatherResponse {
      CurrentWeatherResponse(coordinate: Coordinate(latitude: 0.0, longitude: 0.0), data: TemperatureData(temp: 32.0))
  }
}

public struct TemperatureData: Decodable {
  var temp: Double
}

public struct Coordinate: Decodable {
  var latitude: Double
  var longitude: Double

  private enum CodingKeys: String, CodingKey {
    case latitude = "lat"
    case longitude = "lon"
  }

  // converts to a Core Location coordinate if needed
  func toCoreLocationCoordinate() -> CLLocationCoordinate2D {
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }

  // comparator for Coordinate (Codable) objects
  func areCoordinatesEqualToOther(coord: Coordinate) -> Bool {
    return latitude == coord.latitude && longitude == coord.longitude
  }
}
