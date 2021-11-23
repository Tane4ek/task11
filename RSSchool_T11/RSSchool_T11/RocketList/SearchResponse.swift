//
//  Rockets.swift
//  RSSchool_T11
//
//  Created by Татьяна Лузанова on 11.09.2021.
//

import Foundation

struct SearchResponse: Decodable {
    var name: String
    var costPerLaunch: Int
    var successRatePct: Int
    var firstFlight: String
    var wikipedia: String
    var description: String
    var height: Height
    var diameter: Diameter
    var mass: Mass
    var firstStage: FirstStage
    var secondStage: SecondStage
    var engines: Engines
    var landingLegs: LandingLegs
    var flickrImages: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, wikipedia, description, height, diameter, mass, engines
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case landingLegs = "landing_legs"
        case flickrImages = "flickr_images"
    }
}

//MARK: - Height
extension SearchResponse {
    struct Height: Decodable {
        var meters: Double
    }
}

//MARK: - Diameter
extension SearchResponse {
    struct Diameter: Decodable {
        var meters: Double
    }
}

//MARK: - Mass
extension SearchResponse {
    struct Mass: Decodable {
        var kg: Int
    }
}

//MARK: - FirstStage
extension SearchResponse {
    struct FirstStage: Decodable {
        var burnTimeSec: Int?
        var fuelAmountTons: Double
        var engines: Int
        var reusable: Bool
        var thrustSeaLevel: ThrustSeaLevel
        
        //MARK: - ThrustSeaLevel
        struct ThrustSeaLevel: Decodable {
            var kN: Int
        }
        
        var thrustVacuum: ThrustVacuum
        
        //MARK: -ThrustVacuum
        struct ThrustVacuum: Decodable {
            var kN: Int
        }
     
        enum CodingKeys: String, CodingKey {
            case engines, reusable
            case burnTimeSec = "burn_time_sec"
            case fuelAmountTons = "fuel_amount_tons"
            case thrustSeaLevel = "thrust_sea_level"
            case thrustVacuum = "thrust_vacuum"
        }
    }
}

//MARK: - SecondStage
extension SearchResponse {
    struct SecondStage: Decodable {
        var burnTimeSec: Int?
        var fuelAmountTons: Double
        var engines: Int
        var reusable: Bool
        var thrust: Thrust
        
        //MARK: - Thrust
        struct Thrust: Decodable {
            var kN: Int
        }
        
        var payloads: Payloads
        //MARK: - Payloads
        struct Payloads: Decodable {
            var compositeFairing: CompositeFairing
            
            //MARK: - Composite_fairing
            struct CompositeFairing: Decodable {
                var height: PayloadsHeight
                
                //MARK: - PayloadsHeight
                struct PayloadsHeight: Decodable {
                    var meters: Double?
                }
                
                var diameter: PayloadsDiameter
                //MARK: - PayloadsDiameter
                struct PayloadsDiameter: Decodable {
                    var meters: Double?
                }
            }
    
            var option: String
            
            enum CodingKeys: String, CodingKey {
                case compositeFairing = "composite_fairing"
                case option = "option_1"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case burnTimeSec = "burn_time_sec"
            case fuelAmountTons = "fuel_amount_tons"
            case engines, reusable, thrust, payloads
        }
    }
}

//MARK: - Engines
extension SearchResponse {
    struct Engines: Decodable {
        var type: String
        var layout: String?
        var version: String?
        var number: Int
        var propellantOne: String
        var propellantTwo: String
        
        enum CodingKeys: String, CodingKey {
            case type, layout, version, number
            case propellantOne = "propellant_1"
            case propellantTwo = "propellant_2"
        }
    }
}

//MARK: - LandingLegs
extension SearchResponse {
    struct LandingLegs: Decodable {
        var number: Int
        var material: String?
    }
}
