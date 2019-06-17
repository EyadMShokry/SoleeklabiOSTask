//
//  String+Extensions.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/27/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import Foundation
extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
 }
