//
//  Preferences.swift
//  OutdoorsAdvisor
//
//  Created by Akash Mullick on 3/27/23.
//

import SwiftUI

struct SliderItem : Identifiable {
    var id = UUID()
    var sliderName: String
    var sliderValue: Double
}

class Sliders: ObservableObject {
    @Published var sliders: [SliderItem] = [
        .init(sliderName: "Pollen", sliderValue: 0),
        .init(sliderName: "Air Quality", sliderValue: 0),
        .init(sliderName: "Precipitation", sliderValue: 0),
        .init(sliderName: "Temperature", sliderValue: 0),
        .init(sliderName: "UV", sliderValue: 0)
    ]
}

struct Preferences: View {
    @StateObject var model = Sliders()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Preferences")
                        .font(.title)
                        .bold()
                    Text("0 indicates no preference, 100 indicates high sensitivity pizza")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }.padding(.bottom, 50)
            }
            
            ForEach($model.sliders, id: \.id) { $slider in
                PreferenceSlider(sliderValue: $slider.sliderValue, sliderLabel: slider.sliderName)
            }
        }
    }
}

struct PreferenceSlider: View {
    @Binding var sliderValue: Double
    var sliderLabel: String
    var body: some View {
        VStack {
            Text(sliderLabel)
                .padding(.bottom, -25)
            Slider(value: $sliderValue, in: 0...100) {
                Text("Slider")
            } minimumValueLabel: {
                Text("0").font(.title2).fontWeight(.thin)
            } maximumValueLabel: {
                Text("100").font(.title2).fontWeight(.thin)
            }
            Text("\(sliderValue, specifier: "%.0f")")
                .frame(width: 50)
                .padding(-25)
        }.padding()
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}
