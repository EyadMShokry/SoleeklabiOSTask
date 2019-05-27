//
//  Countries.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/26/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import Foundation

struct CountryData: Decodable {
    let countries: [Country]
}

struct Country: Decodable {
    let name: String
    let capital: String
}
