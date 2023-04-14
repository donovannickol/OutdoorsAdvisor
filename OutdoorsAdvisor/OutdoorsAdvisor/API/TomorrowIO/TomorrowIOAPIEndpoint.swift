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
    
    static func path(coordinate: CLLocationCoordinate2D) -> String {
        let locationParameter = "location=\(coordinate.latitude),lon=\(coordinate.longitude)"
        return "\(baseUrl)?\(locationParameter)&\(apiKey)"
    }
}
