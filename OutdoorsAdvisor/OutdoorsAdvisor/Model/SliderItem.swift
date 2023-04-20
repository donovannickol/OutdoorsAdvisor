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
        SliderItem(sliderName: "Temperature", sliderValue: 50),
        SliderItem(sliderName: "Precipitation", sliderValue: 50),
        SliderItem(sliderName: "UV", sliderValue: 50),
        SliderItem(sliderName: "Humidity", sliderValue: 50),
        SliderItem(sliderName: "Wind", sliderValue: 50),
        SliderItem(sliderName: "Air Quality", sliderValue: 50)
    ]
}
