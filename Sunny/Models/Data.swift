//
//  Data.swift
//  Sunny
//
//  Created by Максим Половинкин on 23.09.2022.
//  
//

import Foundation

struct coord: Decodable {
    var lon: Double
    var lat: Double
}

struct weathe: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    var sea_level: Int
    var grnd_level: Int
}



struct params: Decodable {
    var coord: coord?
    var weather: [weathe]?
    var main: main?
}

