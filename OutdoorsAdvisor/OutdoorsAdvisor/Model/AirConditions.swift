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
    var data: AirData
    
    private enum CodingKeys: String, CodingKey {
        case data
        case coordinate = "location"
    }
    
    static func mock() -> AirConditionsResponse {
        AirConditionsResponse(coordinate: Coordinate(latitude: 0.0, longitude: 0.0), data: AirData(values: AirDataValues(uvIndex: 5, rain: 0, temperature: 60.5)))
    }
}

//json response format:
//{
//  "data": {
//    "time": "2023-04-17T03:00:00Z",
//    "values": {
//      "cloudBase": 0.13,
//      "cloudCeiling": 0.13,
//        etc
        
public struct AirData: Decodable, Hashable {
    var values: AirDataValues
}

public struct AirDataValues: Decodable, Hashable {
    //var pollen
    var uvIndex: Int
    var rain: Double
    var temperature: Double
    
    private enum CodingKeys: String, CodingKey {
        //        case pollenT = "pollenTree"
        //        case pollenG = "pollenGrass"
        case uvIndex
        case rain = "rainIntensity"
        case temperature
    }
}

public struct AirConditionsSummary: Decodable, Hashable {
    var data: AirData
    
}
