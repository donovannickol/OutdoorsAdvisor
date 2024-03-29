import SwiftUI

struct Factor : Identifiable {
    var id = UUID()
    var name: String
    var value: Double
    var total: Double
}


struct DetailView: View {
    @EnvironmentObject var openWeatherLoader: OpenWeatherLoader
    @EnvironmentObject var tomorrowIOLoader: TomorrowIOLoader
    @EnvironmentObject var pollenLoader: PollenLoader
    @EnvironmentObject var dataStore: DataStore
    
    var isDefaultLocation: Bool {
        dataStore.defaultLocation == city.id
    }
    var city: City
    @State var progressValue: Double = 60
    
    var body: some View {
        VStack(alignment: .trailing) {
            ScrollView {
                Text(city.name)
                    .font(.title)
                    .bold().padding(.bottom, 20.0)
                Text("Overall Weather Quality").font(.headline)
                VStack {
                    
                    ProgressBar(progress: self.$progressValue)
                        .frame(width: 150.0, height: 150.0)
                        .padding(.bottom, 40.0)
                        .padding(.top, 20.0)
                        .padding(.top, 20.0)
                }
                var tempPollen: Double = 0
                switch pollenLoader.state {
                case .idle: Color.clear
                case .loading: ProgressView()
                case .failed(let error): Text("Error \(error.localizedDescription)")
                case .success(let pollenSummary):
                    let totalPollen = pollenSummary.pollenGrass + pollenSummary.pollenTree
                    FactorAmount(label: "Pollen", value: Double(totalPollen), total: 10).onAppear(perform: {
                        tempPollen = Double(totalPollen)
                    })
                }
                
                var tempAir: Double = 0
                switch openWeatherLoader.state {
                case .idle: Color.clear
                case .loading: ProgressView()
                case .failed(let error): Text("Error \(error.localizedDescription)")
                case .success(let airData):
                    FactorAmount(label: "Air Quality", value: airData.airQualityIndex, total: 5).onAppear(perform: {
                        tempAir = airData.airQualityIndex
                    })
                }
                
                switch tomorrowIOLoader.state {
                case .idle: Color.clear
                case .loading: ProgressView()
                case .failed(let error): Text("Error \(error.localizedDescription)")
                case .success(let weatherData):
                    
                    let tempFahrenheit = weatherData.temperature * 1.8 + 32.0
                    FactorAmount(label: "Temperature", value: tempFahrenheit, total: 120)
                    FactorAmount(label: "Chance of Precipitation", value: weatherData.rainProbability, total: 100)
                    if weatherData.rainProbability > 0 {
                        FactorAmount(label: "Rain Amount", value: Double(weatherData.rainAmount), total: 10)
                    }
                    FactorAmount(label: "UV Index", value: Double(weatherData.uvIndex), total: 11)
                    FactorAmount(label: "Humidity", value: Double(weatherData.humidity), total: 100)
                    FactorAmount(label: "Wind Speed", value: Double(weatherData.wind), total: 20).onAppear(perform: {
                        
                        let enjoyment = City.cityEnjoyment(weather: weatherData, air: tempAir, pollen: tempPollen, preferences: dataStore.preferences)
                        
                        progressValue = enjoyment
                    })
                }
                
            }
            .task { await tomorrowIOLoader.loadWeatherConditions(city: city) }
            .task { await openWeatherLoader.loadAirData(city: city) }
            .task { await pollenLoader.loadPollen(city: city)}
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(self.isDefaultLocation ? "Default Location" : "Set Default") {
                        UserDefaults.standard.set(city.id, forKey: "defaultLocation")
                        dataStore.defaultLocation = city.id
                    }
                }
            }
        }
    }
}


struct ProgressBar: View {
    @Binding var progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress/100, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(self.percentToColor())
                .rotationEffect(Angle(degrees: 270.0))
            
            Text(String(format: "%.0f %%", self.progress))
                .font(.largeTitle)
                .bold()
        }
    }
    
    private func percentToColor() -> Color {
        let scaled = CGFloat(self.progress) / 100.0
        return Color(red: (1.0 - scaled), green: scaled, blue: 0.0)
    }
}

func percentToColorFactor(progress: Double) -> Color {
    let scaled = CGFloat(progress) / 100.0
    return Color(red: scaled, green: (1 - scaled), blue: 0.0)
}

struct FactorAmount: View {
    var label: String
    var value: Double
    var total: Double
    var recommendationMap = [
        "Pollen": "🐝 Take allergy medicine before going outside!",
        "Air Quality": "😷 Wear a mask when outside!",
        "Temperature": "🌡️ Bring a water bottle and dress light!",
        "Chance of Precipitation": "☔️ Bring an umbrella!",
        "UV Index": "☀️ Wear sunscreen!"
    ]
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label):")
            ProgressView(value: value, total: total)
                .scaleEffect(x: 1, y: 5, anchor: .center)
                .accentColor(percentToColorFactor(progress: value / total * 100))
            if let recommendation = recommendationMap[label] {
                if value / total > 0.75 {
                    Text(recommendation)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct WeatherDisplay: View {
  let currentWeatherConditions: TomorrowIOLoader.WeatherConditionsSummary
  let city: City

  var body: some View {
    VStack {
      Text(city.name).font(.largeTitle)
      Text("Current Conditions".uppercased())
        .font(.caption)
      Text(currentTemperature(currentWeatherConditions))
    }
    .padding(20)
  }
    
  //add currentConditions here (need to add tomorrowio equiv to WeatherInfo.description)

  func currentTemperature(_ conditions: TomorrowIOLoader.WeatherConditionsSummary) -> String {
    let formattedTemp = NumberFormatting.temperature(conditions.temperature) ?? "n/a"
    return "\(formattedTemp)°"
  }
}

struct NumberFormatting {
  static func temperature(_ temperature: Double) -> String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .none
    let temp = NSNumber(value: temperature)
    return formatter.string(from: temp)
  }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(city: City.previewData[0])
            .environmentObject(OpenWeatherLoader(apiClient: MockWeatherAPIClient()))
            .environmentObject(TomorrowIOLoader(apiClient: MockTomorrowIOAPIClient())).environmentObject(PollenLoader(apiClient: MockTomorrowIOAPIClient())).environmentObject(DataStore())
    }
}
