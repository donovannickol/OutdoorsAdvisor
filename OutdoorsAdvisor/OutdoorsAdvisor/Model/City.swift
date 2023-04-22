import Foundation
import CoreLocation

struct City: Identifiable, Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    var id: String {
        "\(latitude)\(longitude)"
    }
    
    struct FormData {
        var name: String = ""
        var latitude: String = ""
        var longitude: String = ""
    }
    
    var dataForForm: FormData {
      FormData(
        name: name,
        latitude: String(latitude),
        longitude: String(longitude)
      )
    }
    
    static func create(from formData: FormData) -> City {
        City(name: formData.name, latitude: Double(formData.latitude) ?? 0, longitude: Double(formData.longitude) ?? 0)
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    static func cityEnjoyment(weather: WeatherDataValues, air: Double, pollen: Double, preferences: [SliderItem]) -> Double{
        var value = preferences[0].sliderValue * (120 - abs(weather.temperature - 70)) + preferences[1].sliderValue * (100 - weather.rainProbability)
        value += preferences[2].sliderValue  * (11 - Double(weather.uvIndex))
        value += preferences[3].sliderValue * (100 - weather.humidity)
        value += preferences[4].sliderValue * weather.wind + preferences[5].sliderValue * air
        value += preferences[6].sliderValue * pollen
        value = value / (preferences[0].sliderValue + preferences[1].sliderValue + preferences[2].sliderValue + preferences[3].sliderValue + preferences[4].sliderValue + preferences[5].sliderValue + preferences[6].sliderValue)
        value += 25 //enjoyment value seems too low always
        return value
    }
}

extension City {
    static let previewData = [
        City(name: "Charlotte", latitude: 35.2271, longitude: -80.8431),
        City(name: "New York", latitude: 40.7128, longitude: -74.0060),
        City(name: "Anguilla", latitude: 18.2206, longitude: -63.0686),
        City(name: "Dar es Salaam", latitude: -6.7924, longitude: 39.2083),
        City(name: "Mumbai", latitude: 19.0760, longitude: 72.8777),
        City(name: "Seoul", latitude: 37.5665, longitude: 126.9780),
        City(name: "Shanghai", latitude: 31.2304, longitude: 121.4737),
        City(name: "Auckland", latitude: 36.8509, longitude: 174.7645)
    ]
}


