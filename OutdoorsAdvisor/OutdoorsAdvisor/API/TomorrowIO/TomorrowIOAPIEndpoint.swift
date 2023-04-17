//
//  TomorrowIOAPIEndpoint.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/14/23.
//

import Foundation
import CoreLocation

struct TomorrowIOAPIEndpoint {
    static let baseUrl = "https://api.tomorrow.io/v4/weather/realtime"
    static let apiKey = "xtkWwQY25s5YG5uszsvHPlxnwGPJ6orY"
    
    static func path(city: String) -> String {
        //let locationParameter = "location=\(coordinate.latitude),%252C\(coordinate.longitude)"
        let locationParameter = "location=\(city)"
        return "\(baseUrl)?\(locationParameter)&apikey=\(apiKey)"
    }
}
