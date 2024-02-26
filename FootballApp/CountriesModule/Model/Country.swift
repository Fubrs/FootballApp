//
//  Country.swift
//  FootballApp
//
//  Created by Nikita Chuklov on 27.02.2024.
//

import Foundation

struct CountryData: Codable {
    let areas: [Country]
}

struct Country: Codable {
    let id: Int
    let name: String
    let countryCode: String
    let flag: String?
    let parentAreaId: Int?
    let parentArea: String?
}
