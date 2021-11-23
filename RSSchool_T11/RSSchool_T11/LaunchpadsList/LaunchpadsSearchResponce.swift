//
//  LaunchpadsSearchResponce.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 29.09.2021.
//

import UIKit

struct LaunchpadsSearchResponse: Decodable {
    var name: String
    var fullName: String
    var locality: String
    var region: String
    var latitude: Double
    var longitude: Double
    var launchAttempts: Int
    var launchSuccesses: Int
    var details: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, latitude, longitude, details, locality
        case fullName = "full_name"
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
    }
}



//"images":{
//         "large":[
//            "https://i.imgur.com/7uXe1Kv.png"
//         ]
//      },
//      "name":"VAFB SLC 3W",
//      "full_name":"Vandenberg Space Force Base Space Launch Complex 3W",
//      "locality":"Vandenberg Space Force Base",
//      "region":"California",
//      "latitude":34.6440904,
//      "longitude":-120.5931438,
//      "launch_attempts":0,
//      "launch_successes":0,
//      "rockets":[
//         "5e9d0d95eda69955f709d1eb"
//      ],
//      "timezone":"America/Los_Angeles",
//      "launches":[
//
//      ],
//      "status":"retired",
//      "details":"SpaceX's original west coast launch pad for Falcon 1. It was used in a static fire test but was never employed for a launch, and was abandoned due to range scheduling conflicts arising from overflying other active pads.",
//      "id":"5e9e4501f5090910d4566f83"
//   },
