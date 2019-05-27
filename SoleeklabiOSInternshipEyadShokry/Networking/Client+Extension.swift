//
//  Client+Extension.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/26/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import Foundation

extension Client {
    
    struct RESTCountries {
        static let APIScheme = "https"
        static let APIHost = "restcountries.eu"
        static let APIPath = "/rest/v2/all"
    }
    
    struct RESTCountriesParameterKeys {
        static let Fields = "fields"
    }
    
    struct RESTCountiresParameterValues {
        static let Fields = "name;capital"
    }
}
