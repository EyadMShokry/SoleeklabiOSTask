//
//  CountryTableViewCell.swift
//  SoleeklabiOSInternshipEyadShokry
//
//  Created by Eyad Shokry on 5/26/19.
//  Copyright © 2019 Eyad. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    
    func configureCellWith(countryName: String, CapitalName: String) {
        countryNameLabel.text = countryName
        capitalNameLabel.text = "Capital Name: \(CapitalName)"
    }
}
