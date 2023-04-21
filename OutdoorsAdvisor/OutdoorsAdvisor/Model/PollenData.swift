//
//  PollenData.swift
//  OutdoorsAdvisor
//
//  Created by Charlotte McCulloh (cm548) on 4/21/23.
//

import Foundation

public struct PollenResponse: Decodable {
    var data: PollenDataWrapper
    
    private enum CodingKeys: String, CodingKey, Hashable {
        case data
    }
    
    static func mock() -> PollenResponse {
        PollenResponse(data: PollenDataWrapper(timelines: [PollenInterval(timestep: "1hr", intervals: [PollenData(values: PollenSummary(pollenGrass: 1, pollenTree: 3))])]))
    }
}

//json response structure:
//{ data: {
//    timelines: [ {
//      timestep, endTime, startTime
//      intervals: [ {
//        startTime
//          values: { grassIndex: Int, treeIndex: Int } ] }}}

public struct PollenDataWrapper: Decodable, Hashable {
    var timelines: [PollenInterval]
}

public struct PollenInterval: Decodable, Hashable {
    var timestep: String
    var intervals: [PollenData]
}

public struct PollenData: Decodable, Hashable {
    var values: PollenSummary
}

public struct PollenSummary: Decodable, Hashable {
    var pollenGrass: Int
    var pollenTree: Int
    
    private enum CodingKeys: String, CodingKey {
        case pollenGrass = "grassIndex"
        case pollenTree = "treeIndex"
    }
}
