//
//  CityModel.swift
//  SampleRxSwift
//
//  Created by Roy Cruz on 7/29/20.
//  Copyright © 2020 Roy Cruz. All rights reserved.
//

import Foundation

struct Response: Codable {
    let data: Array<CityModel>
    
}

struct CityModel: Codable {
    let id: Int
    let name: String
    let country: CountryModel
}

struct CountryModel:Codable {
    let name: String
}
