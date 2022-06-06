//
//  FligthInfo.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//

import Foundation

struct FetchResult: Decodable {
    let data: [FlightInfo]
}

struct FlightInfo: Decodable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
}
