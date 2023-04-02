//
//  PreferenceSlider.swift
//  OutdoorsAdvisor
//
//  Created by Akash Mullick on 3/27/23.
//

import SwiftUI

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

struct PreferenceSlider_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceSlider(sliderValue: Binding.constant(0.0), sliderLabel: "Pollen")
    }
}
