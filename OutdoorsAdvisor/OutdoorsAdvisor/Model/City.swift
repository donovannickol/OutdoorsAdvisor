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
    
    static func getCityById(_ id: String) -> City? {
        return City.previewData.first(where: { $0.id == id })
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

