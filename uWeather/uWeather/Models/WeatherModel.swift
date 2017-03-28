//
//  WeatherModel.swift
//  uWeather
//
//  Created by Pavlo Ivanov on 3/28/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class WeatherModel: NSObject {
    var id: Int?
    var cityName: String?
    var humidity: Int?
    var pressure: Double?
    var temperature: Double?
    var descriptionMessage: String?
    var iconName: String?
    var mainWeather: String?
    var wind: Wind?
    
    init(json: [String:Any]) {
        super.init()
        self.id = json["id"] as? Int
        self.cityName = json["name"] as? String
        let main = json["main"] as? [String:Any]
        self.humidity = main?["humidity"] as? Int
        self.pressure = main?["pressure"] as? Double
        let temp = main?["temp"] as! Double
        self.temperature = Double(temp - 273.15)
        let weather = json["weather"] as? [[String:Any]]
        self.descriptionMessage = weather?[0]["description"] as? String
        self.iconName = weather?[0]["icon"] as? String
        self.mainWeather = weather?[0]["main"] as? String
        self.wind = Wind(json: json["wind"] as! [String:Any])
    }
    
    private func convertToCelsius(fahrenheit: Int) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}

class Wind: NSObject {
    var deg: Int?
    var direction: String?
    var speed: Int?
    
    init(json: [String:Any]) {
        self.deg = json["deg"] as? Int
        self.speed = json["speed"] as? Int
    }
}
