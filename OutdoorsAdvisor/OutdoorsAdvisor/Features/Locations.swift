//
//  Locations.swift
//  OutdoorsAdvisor
//
//  Created by Akash Mullick on 4/2/23.
//

import SwiftUI

struct Locations: View {
    @State private var searchText = ""
    @State private var isShowingAddSheet = false
    @State private var newLocationName = ""
    @State private var locations = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"]
    
    var filteredLocations: [String] {
        if searchText.isEmpty {
            return locations
        } else {
            return locations.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Locations")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: {
                        self.isShowingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title)
                    }
                }
                .padding()
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                List(filteredLocations, id: \.self) { location in
                    NavigationLink(destination: DetailView(location: location)) {
                        LocationItem(location: location, value: 60)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .sheet(isPresented: $isShowingAddSheet, content: {
                VStack {
                    HStack {
                        Button("Cancel") {
                            self.isShowingAddSheet = false
                        }
                        Spacer()
                        Button("Add") {
                            self.locations.append(self.newLocationName)
                            self.newLocationName = ""
                            self.isShowingAddSheet = false
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    
                    TextField("Location Name", text: self.$newLocationName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            })
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
    var location: String
    var value: Double
    
    var body: some View {
        HStack {
            Text(location)
                .font(.headline)
                .padding(.leading)
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
    }
}
