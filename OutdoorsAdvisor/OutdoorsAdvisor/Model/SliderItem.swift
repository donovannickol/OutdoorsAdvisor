import Foundation

struct SliderItem : Identifiable {
    var id = UUID()
    var sliderName: String
    var sliderValue: Double
    
    struct FormData {
        var sliderName: String = ""
        var sliderValue: Double = 0.0
    }
    
    var dataForForm: FormData {
        FormData(
            sliderName: sliderName,
            sliderValue: sliderValue
        )
    }
    
}

extension SliderItem {
    static let previewData = [
        SliderItem(sliderName: "Pollen", sliderValue: 0),
        SliderItem(sliderName: "Air Quality", sliderValue: 0),
        SliderItem(sliderName: "Precipitation", sliderValue: 0),
        SliderItem(sliderName: "Temperature", sliderValue: 0),
        SliderItem(sliderName: "UV", sliderValue: 0)
    ]
}
