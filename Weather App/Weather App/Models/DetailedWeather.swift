//
//  DetailedWeather.swift
//  Weather App
//
//  Created by Tommy on 3/6/23.
//

import Foundation

class DetailedWeather {
    var iconName: String
    var title: String
    var parameter: String
    var desc: String
    
    init(iconName: String, title: String,parameter: String, desc: String) {
        self.iconName = iconName
        self.title = title
        self.parameter = parameter
        self.desc = desc
    }
}
