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
        AirConditionsResponse(coordinate: Coordinate(latitude: 0.0, longitude: 0.0), data: AirData(values: AirDataValues(uvIndex: 5, rainAmount: 0, rainProbability: 0, temperature: 60.5, humidity: 96, wind: 2.38)))
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
    var rainAmount: Double
    var rainProbability: Double
    var temperature: Double
    var humidity: Double
    var wind: Double
    
    private enum CodingKeys: String, CodingKey {
        //        case pollenT = "pollenTree"
        //        case pollenG = "pollenGrass"
        case uvIndex
        case rainAmount = "rainIntensity"
        case rainProbability = "precipitationProbability"
        case temperature
        case humidity
        case wind = "windSpeed"
    }
}

public struct AirConditionsSummary: Decodable, Hashable {
    var data: AirData
    
}
