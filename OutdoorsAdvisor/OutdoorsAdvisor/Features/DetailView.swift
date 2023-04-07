import SwiftUI

struct Factor : Identifiable {
    var id = UUID()
    var name: String
    var value: Double
    var total: Double
}


struct DetailView: View {
    // mock data for testing view, replace with API results later
    @EnvironmentObject var currentConditionsLoader: CurrentConditionsLoader
    var city: City
    @State var progressValue: Float = 60
    var factors: [Factor] = [
        Factor(name: "Temperature", value: 50, total: 100),
        Factor(name: "Air Quality", value: 43, total: 100),
        Factor(name: "Pollen", value: 77, total: 100),
        Factor(name: "UV", value: 12, total: 100),
        Factor(name: "Precipitation", value: 37, total: 100)
    ]
    
    var body: some View {
        ScrollView {
            Text(city.name)
                .font(.title)
                .bold()
            
            VStack {
                ProgressBar(progress: self.$progressValue)
                    .frame(width: 150.0, height: 150.0)
                    .padding(40.0)
                
                ForEach(factors, id: \.id) { factor in
                    FactorAmount(label: factor.name, value: factor.value, total: factor.total)
                }
            }
            switch currentConditionsLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): Text("Error \(error.localizedDescription)")
            case .success(let currentConditions):
              WeatherDisplay(currentConditions: currentConditions, city: city)
            }

        }.task { await currentConditionsLoader.loadWeatherData(city: city) }
    }
    
}

struct ProgressBar: View {
    @Binding var progress: Float
    
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

struct FactorAmount: View {
    var label: String
    var value: Double
    var total: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(label):")
            ProgressView(value: value, total: total)
                .scaleEffect(x: 1, y: 5, anchor: .center)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

struct WeatherDisplay: View {
  let currentConditions: CurrentConditionsLoader.CurrentConditionsSummary
  let city: City

  var body: some View {
    VStack {
      Text(city.name).font(.largeTitle)
      Text("Current Conditions".uppercased())
        .font(.caption)
      Text(currentConditions.description)
      Text(currentTemperature(currentConditions))
    }
    .padding(20)
  }

  func currentConditions(_ weather: WeatherInfo) -> String {
    weather.description
  }

  func currentTemperature(_ conditions: CurrentConditionsLoader.CurrentConditionsSummary) -> String {
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
        DetailView(city: City.previewData[0]).environmentObject(ForecastLoader(apiClient: MockWeatherAPIClient()))
            .environmentObject(CurrentConditionsLoader(apiClient: MockWeatherAPIClient()))
    }
}