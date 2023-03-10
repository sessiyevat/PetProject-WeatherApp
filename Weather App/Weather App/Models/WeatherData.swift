//
//  WeatherData.swift
//  App2
//
//  Created by Сая Атчибай on 11/11/22.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: MainData
    let name: String
    let visibility: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
}

struct MainData: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
    let humidity: Int
    let pressure: Int
}

