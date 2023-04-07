import Foundation

class DataStore: ObservableObject {
    @Published var preferences: [SliderItem] = SliderItem.previewData
    @Published var cities: [City] = City.previewData
    
    func createCity(_ city: City) {
        cities.append(city)
    }
}
