import SwiftUI

struct TabContainer: View {
    @StateObject var dataStore = DataStore()
    @StateObject var forecastLoader = ForecastLoader(apiClient: WeatherAPIClient())
    @StateObject var currentConditionsLoader = CurrentConditionsLoader(apiClient: WeatherAPIClient())
    
    @State var currentWeatherCity: City?
    
    var body: some View {
        TabView{
            NavigationView {
                DetailView(city: City.getCityById(UserDefaults.standard.string(forKey: "defaultLocation") ?? "") ?? City.previewData[0])
                    .environmentObject(forecastLoader)
                    .environmentObject(currentConditionsLoader)
            }
            .tabItem {
                Label("Home", systemImage: "cloud.sun.rain")
            }
//            NavigationView {
//                DetailView(city: City.previewData[0])
//                    .environmentObject(forecastLoader)
//                    .environmentObject(currentConditionsLoader)
//            }
//            .tabItem {
//                Label("Details", systemImage: "book")
//            }
            NavigationView {
                //Map
            }
            .tabItem {
                Label("Map", systemImage: "map")
            }
            NavigationView {
                Locations()
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
    }
}

struct TabContainer_Previews: PreviewProvider {
    static var previews: some View {
        TabContainer()
    }
}

