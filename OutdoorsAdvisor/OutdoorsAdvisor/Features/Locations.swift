import SwiftUI

struct Locations: View {
    @EnvironmentObject var dataStore: DataStore
    @StateObject var currentConditionsLoader = CurrentConditionsLoader(apiClient: WeatherAPIClient())
    
    @State private var searchText = ""
    @State private var newLocationName = ""
    
    @State var isPresentingCityForm: Bool = false
    @State var newCityFormData = City.FormData()
    
    var filteredLocations: [City] {
        if searchText.isEmpty {
            return dataStore.cities.sorted { $0.name < $1.name }
        } else {
            return dataStore.cities.filter { $0.name.lowercased().contains(searchText.lowercased())
            }.sorted { $0.name < $1.name }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Locations")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        self.isPresentingCityForm = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }
                .padding()
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                List(filteredLocations) { location in
                    NavigationLink(destination: DetailView(city: location)
                        .environmentObject(currentConditionsLoader)) {
                        LocationItem(location: location, value: 60)
                    }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                dataStore.removeCity(location)
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                .listStyle(.insetGrouped)
            }
            .sheet(isPresented: $isPresentingCityForm) {
                NewCityForm(isPresentingCityForm: $isPresentingCityForm, newCityFormData: $newCityFormData)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $text)
                .font(.headline)
        }
        .padding(8)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

struct LocationItem: View {
    var location: City
    var value: Double
    
    var body: some View {
        HStack {
            Text(location.name)
                .font(.headline)
                .padding(.leading)
            if location.id == UserDefaults.standard.string(forKey: "defaultLocation") {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            Spacer()
            Text(String(format: "%.0f%%", value))
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

struct Locations_Previews: PreviewProvider {
    static var previews: some View {
        Locations()
            .environmentObject(DataStore())
    }
}
