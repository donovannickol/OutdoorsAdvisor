//
//  AirConditions.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/14/23.
//

import Foundation
import CoreLocation

public struct AirConditionsResponse: Decodable {
    var coordinate: Coordinate
    //var pollen
    var uvIndex: Int
    var rain: Double
    
    private enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        //        case pollenT = "pollenTree"
        //        case pollenG = "pollenGrass"
        case uvIndex
        case rain = "rainIntensity"
    }
    
    static func mock() -> AirConditionsResponse {
        AirConditionsResponse(coordinate: Coordinate(latitude: 0.0, longitude: 0.0), uvIndex: 5, rain: 0)
    }
}
