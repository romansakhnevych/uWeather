//
//  WeatherServices.swift
//  uWeather
//
//  Created by Pavlo Ivanov on 3/28/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit
import Kingfisher

let appIdParam = "&APPID=b70b497a55e12e37bb35f98f75dc462a"
let imageDownloadUrl = "http://openweathermap.org/img/w/"

class WeatherServices: NSObject {
    
    let session = URLSession.shared
    
    func getWeather(city: String, success: (@escaping (_: WeatherModel) -> ()), failer:(@escaping(_: Error) -> ())) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + city + appIdParam)
        let task = session.dataTask(with: url!) { (data, response, error) in
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                print(jsonDictionary)
                let weatherModel = WeatherModel(json: jsonDictionary as! [String : Any])
                success(weatherModel)
            } catch {
                print(error)
                failer(error)
            }
        }
        task.resume()
    }
    
    func getForecast(city:String, success: (@escaping (_: [DailyWeatherModel]) -> ()), failure: (@escaping (_: Error) -> ())) {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=" + city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! + "&cnt=7" + appIdParam)
        let task = session.dataTask(with: url!) { (data, response, error) in
            do{
                let jsonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as! [String:Any]
                print(jsonDictionary)
                let dailyForecastArray = jsonDictionary["list"] as! [[String:Any]]
                var modelsArray = [DailyWeatherModel]()
                for jsonObject in dailyForecastArray {
                    modelsArray.append(DailyWeatherModel(json:jsonObject))
                }
               success(modelsArray)
            } catch {
                print(error)
                failure(error)
            }
        }
        task.resume()
    }
    
}
