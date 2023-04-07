import Foundation

class DataStore: ObservableObject {
    @Published var preferences: [SliderItem] = SliderItem.previewData
}
