import SwiftUI

struct Preferences: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        ScrollView {
            HStack{
                VStack {
                    Text("Preferences")
                        .font(.title)
                        .bold()
                        .padding(10)
                    Text("0 indicates no preference, 100 indicates high sensitivity")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }.padding(.bottom, 30)
            }
            
            ForEach($dataStore.preferences, id: \.id) { $slider in
                PreferenceSlider(sliderValue: $slider.sliderValue, sliderLabel: slider.sliderName)
                    .onChange(of: slider.sliderValue) { newValue in
                        UserDefaults.standard.setValue(newValue, forKey: slider.sliderName)
                    }
            }
        }
        .onAppear {
            // Load preferences from UserDefaults
            for i in 0..<dataStore.preferences.count {
                if let value = UserDefaults.standard.value(forKey: dataStore.preferences[i].sliderName) as? Double {
                    dataStore.preferences[i].sliderValue = value
                }
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
                .padding(.bottom, -10)
            Slider(value: $sliderValue, in: 0...100) {
                Text("Slider")
            } minimumValueLabel: {
                Text("0").font(.title2).fontWeight(.thin)
            } maximumValueLabel: {
                Text("100").font(.title2).fontWeight(.thin)
            }
            Text("\(sliderValue, specifier: "%.0f")")
                .frame(width: 50)
                .padding(-15)
        }.padding()
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
            .environmentObject(DataStore())
    }
}
