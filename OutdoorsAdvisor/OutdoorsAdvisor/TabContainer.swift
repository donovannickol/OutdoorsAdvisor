import SwiftUI

struct TabContainer: View {
    @EnvironmentObject var dataStore: DataStore
    @EnvironmentObject var openWeatherLoader: OpenWeatherLoader
    @EnvironmentObject var tomorrowIOLoader: TomorrowIOLoader
    @EnvironmentObject var pollenLoader: PollenLoader
    @State var currentWeatherCity: City?
    
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        TabView{
            NavigationView {
                DetailView(city: City.getCityById(UserDefaults.standard.string(forKey: "defaultLocation") ?? "") ?? City.previewData[0])
                    .environmentObject(openWeatherLoader)
                    .environmentObject(tomorrowIOLoader)
                    .environmentObject(pollenLoader)
                    .environmentObject(dataStore)
            }
            .tabItem {
                Label("Home", systemImage: "cloud.sun.rain")
            }
            NavigationView {
                Locations()
                    .environmentObject(openWeatherLoader)
                    .environmentObject(tomorrowIOLoader)
                    .environmentObject(pollenLoader)
                    .environmentObject(dataStore)
            }
            .tabItem {
                Label("Locations", systemImage: "list.star")
            }
            NavigationView {
                Preferences()
                    .environmentObject(dataStore)
            }
            .tabItem {
                Label("Preferences", systemImage: "gearshape")
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer() {}
            .environmentObject(DataStore()).environmentObject(OpenWeatherLoader(apiClient: MockWeatherAPIClient())).environmentObject(TomorrowIOLoader(apiClient: MockTomorrowIOAPIClient())).environmentObject(PollenLoader(apiClient: MockTomorrowIOAPIClient()))
    }
}

