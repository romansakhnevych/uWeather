//
//  DailyWeatherModel.swift
//  uWeather
//
//  Created by Pavlo Ivanov on 3/28/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class DailyWeatherModel: NSObject {

    var date: Date?
    var dateString: String?
    var temperature: Double?
    var iconName: String?
    var windSpeed: Double?
    var pressure: Double?
    
    init(json: [String:Any]) {
        self.windSpeed = json["speed"] as? Double
        self.pressure = json["pressure"] as? Double
        let timestamp = json["dt"] as? TimeInterval
        self.date = NSDate(timeIntervalSince1970: timestamp!) as Date
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        self.dateString = formatter.string(from: date!)
        let temp = json["temp"] as! [String:Double]
        let toConvertTemp = temp["min"]! as Double
        self.temperature = Double(round(10*(toConvertTemp - 273.15))/10)
        let weather = json["weather"] as? [[String:Any]]
        self.iconName = weather?[0]["icon"] as? String
    }
}
