//
//  WeatherViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/21/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

let degree = "\u{00B0}"

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dailyWeatherArray = [DailyWeatherModel]()
    let weatherServices = WeatherServices()
    var weatherModel: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDailyWeather(city:String) {
        weatherServices.getForecast(city: city, success: { (dailyWeatherArray) in
            self.dailyWeatherArray = dailyWeatherArray
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
}

extension WeatherViewController: WeatherDataSourceProtocol {
    func fill(model: WeatherModel) {
        self.weatherModel = model
        temperatureLabel.text = String(model.temperature!) + degree
        cityLabel.text = model.cityName!
        getDailyWeather(city: model.cityName!)
    }
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: WeatherCell.self), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let weatherCell = cell as! WeatherCell
        weatherCell.fill(model:dailyWeatherArray[indexPath.row])
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: collectionView.frame.height)
    }
   
}
