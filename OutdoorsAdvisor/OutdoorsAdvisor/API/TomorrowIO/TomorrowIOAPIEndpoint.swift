//
//  TomorrowIOAPIEndpoint.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/14/23.
//

import Foundation
import CoreLocation

struct TomorrowIOAPIEndpoint {
    static let baseUrl = "https://api.tomorrow.io/v4"
    static let apiKey = "iVwOmHfoBDl26nCpiKyIvw5ij9JlJiVx"
    //in case of maxed out calls: xtkWwQY25s5YG5uszsvHPlxnwGPJ6orY
    
    enum QueryType: String {
        case weather = "weather/realtime"
        case pollen = "timelines"
    }
    
    static func path(city: String, queryType: QueryType) -> String {
        var queryParameters = ""
        if queryType == .weather {
            let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            queryParameters = "location=\(cityEncoded)&"
        }
        return "\(baseUrl)/\(queryType.rawValue)?\(queryParameters)apikey=\(apiKey)"
    }
}
