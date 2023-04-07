import Foundation
import CoreLocation

struct City: Identifiable {
    let id: String
    let name: String
    let latitude: Double
    let longitude: Double
    
    struct FormData {
        var id: String = ""
        var name: String = ""
        var latitude: String = ""
        var longitude: String = ""
    }
    
    var dataForForm: FormData {
      FormData(
        id: id,
        name: name,
        latitude: String(latitude),
        longitude: String(longitude)
      )
    }
    
    static func create(from formData: FormData) -> City {
        City(id: formData.id, name: formData.name, latitude: Double(formData.latitude) ?? 0, longitude: Double(formData.longitude) ?? 0)
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
        City(id: "1", name: "Charlotte", latitude: 35.2271, longitude: -80.8431),
        City(id: "2", name: "New York", latitude: 40.7128, longitude: -74.0060),
        City(id: "3", name: "Anguilla", latitude: 18.2206, longitude: -63.0686),
        City(id: "4", name: "Dar es Salaam", latitude: -6.7924, longitude: 39.2083),
        City(id: "5", name: "Mumbai", latitude: 19.0760, longitude: 72.8777),
        City(id: "6", name: "Seoul", latitude: 37.5665, longitude: 126.9780),
        City(id: "7", name: "Shanghai", latitude: 31.2304, longitude: 121.4737),
        City(id: "8", name: "Auckland", latitude: 36.8509, longitude: 174.7645)
    ]
}

