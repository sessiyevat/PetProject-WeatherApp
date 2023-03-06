//
//  WeatherManager.swift
//  App2
//
//  Created by Сая Атчибай on 11/11/22.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, with model: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    func fetchRequest(){
        let link = "https://api.openweathermap.org/data/2.5/weather?lat=43.25654&lon=76.92848&units=metric&appid=ce9862cf8957ba4500e65a343779314c"
        guard let URL = URL(string: link) else {
            return
        }
        let task = URLSession.shared.dataTask(with: URL) { data, response, error in
            if let data, error == nil {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode(WeatherData.self, from: data)
                    let cityName = decodedData.name
                    let temp = decodedData.main.temp
                    let desc = decodedData.weather[0].description
                    let lTemp = decodedData.main.temp_min
                    let hTemp = decodedData.main.temp_max
                    let feelsLike = decodedData.main.feels_like
                    let humidity = decodedData.main.humidity
                    let pressure = decodedData.main.pressure
                    let visibility = decodedData.visibility
                    let weatherModel = WeatherModel(cityName: cityName, temp: temp, desc: desc, hTemp: hTemp, lTemp: lTemp, feelsLike: feelsLike, humidity: humidity, pressure: pressure, visibility: visibility)
                    delegate?.didUpdateWeather(self, with: weatherModel)
                } catch {
                    print("Nothing has been retrieved! \(error)")
                    return
                }
            } else {
                print("Nothing has been retrieved! \(String(describing: error))")
            }
        }
        task.resume()
    }
}

