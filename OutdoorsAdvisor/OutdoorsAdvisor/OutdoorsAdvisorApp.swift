import SwiftUI

@main
struct OutdoorsAdvisorApp: App {
    @StateObject var forecastLoader = ForecastLoader(apiClient: WeatherAPIClient())
    @StateObject var currentConditionsLoader = CurrentConditionsLoader(apiClient: WeatherAPIClient())
    var body: some Scene {
        WindowGroup {
            TabContainer().environmentObject(forecastLoader)
                .environmentObject(currentConditionsLoader)
        }
    }
}
