import SwiftUI

@main
struct OutdoorsAdvisorApp: App {
    @StateObject var dataStore = DataStore()
    @StateObject var currentConditionsLoader = CurrentConditionsLoader(apiClient: WeatherAPIClient())
    @StateObject var tomorrowIOLoader = TomorrowIOLoader(apiClient: TomorrowIOAPIClient())
    
    @State var hasSaveLoadError: Bool = false
    @State var currentError: Error?
    @State var errorGuidance: String?
    
    var body: some Scene {
        WindowGroup {
            TabContainer(saveAction: {
                Task {
                    do {
                        try await DataStore.save(cities: dataStore.cities)
                    } catch {
                        hasSaveLoadError = true
                        currentError = error
                        errorGuidance = "Try again later."
                    }
                }
            }
            )
            .environmentObject(currentConditionsLoader)
            .environmentObject(dataStore)
            .environmentObject(tomorrowIOLoader)
            .task {
              do {
                dataStore.cities = try await DataStore.load()
              } catch {
                hasSaveLoadError = true
                currentError = error
                errorGuidance = "Try again later."
              }
            }
            .alert("Error", isPresented: $hasSaveLoadError, actions: {
              Button("OK") {
                self.hasSaveLoadError = false
                self.currentError = nil
                self.errorGuidance = nil
              }}, message: {
                VStack {
                  Text(currentError?.localizedDescription ?? "Error")
                  Text(errorGuidance ?? "")
                }
              })
        }
    }
}
