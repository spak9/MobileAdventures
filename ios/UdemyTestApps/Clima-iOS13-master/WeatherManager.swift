//
//  WeatherManager.swift
//  Clima
//
//  Created by stevenpak on 5/27/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager {
    
    // Properties
    var delegate: WeatherManagerDelegate?
    
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=1af2d08fec02c4eb3b7b02a1b1f72283&units=imperial"
    
    
    // Functions
    func fetchWeather(cityName: String) {
        let url = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: url)
    }
    
    func fetchTest() {
        performRequest(urlString: "https://sha256.badssl.com/")
    }
    
    func performRequest(urlString: String) {
        
        // 1. URL (NSURL)
        if let url = URL(string: urlString) {
            
            // 2. URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if url.scheme == "https" {
                    if let safeData = data {
                        if let weatherModel = parseJSON(weatherData: safeData) {
                            self.delegate?.didUpdateWeather(weather: weatherModel)
                        }
                    }
                }
                else {
                    if let safeData = data {
                        print("HERE: \(String(data: safeData, encoding: String.Encoding.utf8)!)")
                    }
                    
                }
            }
            
            // 4. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            let weatherModel = WeatherModel(conditionCode: id, cityName: cityName, temperature: temp)
            return weatherModel

        } catch {
            print(error)
        }
        return nil
    }
    
}
