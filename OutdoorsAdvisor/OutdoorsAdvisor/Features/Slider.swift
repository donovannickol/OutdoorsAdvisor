//
//  Slider.swift
//  OutdoorsAdvisor
//
//  Created by Akash Mullick on 3/27/23.
//

import SwiftUI

struct Slider: View {
    @State var sliderValue : Float = 0.0
    var body: some View {
        Slider(value: $sliderValue, in: 0...10) {
            Text("Slider")
        } minimumValueLabel: {
            Text("0").font(.title2).fontWeight(.thin)
        } maximumValueLabel: {
            Text("10").font(.title2).fontWeight(.thin)
        }.padding()
    }
}

struct Slider_Previews: PreviewProvider {
    static var previews: some View {
        Slider()
    }
}
