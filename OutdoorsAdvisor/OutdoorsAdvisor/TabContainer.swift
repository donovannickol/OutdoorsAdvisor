//
//  TabContainer.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/2/23.
//

import SwiftUI

struct TabContainer: View {
    @State var currentWeatherCity: City?

    var body: some View {
        TabView{
            NavigationView {
              //Home
            }
            .tabItem {
              Label("Home", systemImage: "cloud.sun.rain")
            }
            NavigationView {
                DetailView(city: City.previewData[0])
            }
            .tabItem {
            Label("Details", systemImage: "book")
            }
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

