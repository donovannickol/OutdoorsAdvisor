import Foundation
import CoreLocation

public struct CurrentWeatherResponse: Decodable {
  var coordinate: Coordinate
  var weathers: [WeatherInfo]
  var name: String
  var data: WeatherData
  var wind: Wind
  var clouds: Clouds

  // There are some keys like dt, sys, base, etc. that I don't want to deal with
  // So I will put just the keys I want here and rename some I like the least
  private enum CodingKeys: String, CodingKey {
    case coordinate = "coord"
    case weathers = "weather"
    case name
    case data = "main"
    case wind
    case clouds
  }

  static func mock() -> CurrentWeatherResponse {
    CurrentWeatherResponse(coordinate: Coordinate(latitude: 0.0, longitude: 0.0), weathers: [WeatherInfo(id: 0, main: WeatherCondition.snow, description: "It's snowing", icon: "Snow")], name: "Snowing", data: WeatherData(temp: 32.0, humidity: 30, low: 20.0, high: 45.0), wind: Wind(speed: 5.0, deg: 6, gust: 10.0), clouds: Clouds(coverage: 50.0))
  }
}

// I'm fine to decode all the keys, so this one is pretty simple.
// In reality, I'd want to rename 'main' to 'condition' but left as-is as an example
public struct WeatherInfo: Decodable, Hashable {
  var id: Int
  var main: WeatherCondition
  var description: String
  var icon: String
}

public struct WeatherData: Decodable, Hashable {
  var temp: Double
  var humidity: Int
  var low: Double
  var high: Double

  private enum CodingKeys: String, CodingKey {
    case temp
    case humidity
    case low = "temp_min"
    case high = "temp_max"
  }
}

// Finally! One we did not redefine keys for!
public struct Wind: Decodable, Hashable {
  var speed: Double
  var deg: Int
  var gust: Double?
}

public struct Clouds: Decodable, Hashable {
  var coverage: Double

  private enum CodingKeys: String, CodingKey {
    case coverage = "all"
  }
}

public struct Rain: Decodable {
  var threeHourChance: Double

  public enum CodingKeys: String, CodingKey {
    case threeHourChance = "3h"
  }
}

public struct ForecastResponse: Decodable {
  var dailyForecasts: [ForecastSummary]

  private enum CodingKeys: String, CodingKey {
    case dailyForecasts = "list"
  }
}

// Ugh.  The rain key may not be present, but if it is, I want to use it. So this got complicated.
public struct ForecastSummary: Decodable, Hashable {
  var data: WeatherData
  var weather: [WeatherInfo]
  var clouds: Clouds
  var wind: Wind
  var visibility: Int
  var threeHourChanceOfRain: Double
  var date: Date

    static func mockCollection() -> [ForecastSummary] {
      [ForecastSummary(data: WeatherData(temp: 60.0, humidity: 20, low: 40.0, high: 80.0), weather: [WeatherInfo(id: 1, main: .clear, description: "Clear", icon: "Sun")], clouds: Clouds(coverage: 0.0), wind: Wind(speed: 10.0, deg: 5, gust: 20.0), visibility: 5, threeHourChanceOfRain: 20.0, date: Date()),
       ForecastSummary(data: WeatherData(temp: 20.0, humidity: 20, low: 10.0, high: 30.0), weather: [WeatherInfo(id: 1, main: .clouds, description: "Cloudy", icon: "Cloud")], clouds: Clouds(coverage: 80.0), wind: Wind(speed: 10.0, deg: 5, gust: 20.0), visibility: 5, threeHourChanceOfRain: 20.0, date: Calendar.current.date(byAdding: .day, value: 1, to: Date())! )
      ]
    }
  }

extension ForecastSummary {

  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    self.data = try values.decode(WeatherData.self, forKey: .data)
    self.weather = try values.decode([WeatherInfo].self, forKey: .weather)
    self.clouds = try values.decode(Clouds.self, forKey: .clouds)
    self.wind = try values.decode(Wind.self, forKey: .wind)
    self.visibility = try values.decode(Int.self, forKey: .visibility)

    self.date = try values.decode(Date.self, forKey: .date)

    if let rainContainer = try? values.nestedContainer(keyedBy: Rain.CodingKeys.self, forKey: .rain),
       let rainChance = try rainContainer.decodeIfPresent(Double.self, forKey: .threeHourChance) {
      threeHourChanceOfRain = rainChance
    } else {
      self.threeHourChanceOfRain = 0
    }
  }

  private enum CodingKeys: String, CodingKey {
    case weather
    case data = "main"
    case wind
    case clouds
    case visibility
    case rain
    case date = "dt_txt"
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

enum WeatherCondition: String, Decodable {
  case thunderstorm = "Thunderstorm"
  case drizzle = "Drizzle"
  case rain = "Rain"
  case snow = "Snow"
  case clear = "Clear"
  case clouds = "Clouds"
  case mist = "Mist"
  case smoke = "Smoke"
  case haze = "Haze"
  case dust = "Dust"
  case fog = "Fog"
  case sand = "Sand"
  case ash = "Ash"
  case squall = "Squall"
  case tornado = "Tornado"
}

