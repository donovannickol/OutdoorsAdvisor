import Foundation
import CoreLocation

public struct AirPollutionResponse: Decodable {
  var coordinate: Coordinate
  var data: [AirQualityData]

  private enum CodingKeys: String, CodingKey {
    case coordinate = "coord"
    case data = "list"
  }

  static func mock() -> AirPollutionResponse {
      AirPollutionResponse(coordinate: Coordinate(latitude: 0.0, longitude: 0.0), data: [AirQualityData(airQualityIndexWrapper: AirQualityInfo(airQualityIndex: 2))])
  }
}

//json format:
//{coord: {lon, lat}, list: [{main: {aqi}, components: {...}, dt: }]}

public struct AirQualityData: Decodable, Hashable {
    var airQualityIndexWrapper: AirQualityInfo
//    var components: [AirPollutant]
//    var date: Date
    
    private enum CodingKeys: String, CodingKey {
      case airQualityIndexWrapper = "main"
    }
}

public struct AirQualityInfo: Decodable, Hashable {
    var airQualityIndex: Double
    
    private enum CodingKeys: String, CodingKey {
        case airQualityIndex = "aqi"
    }
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
