//
//  WeatherCell.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/27/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
}

extension WeatherCell {
    func fill(model: DailyWeatherModel) {
        temperatureLabel.text = String(model.temperature!) + degree
        weatherImageView.image = UIImage(named: "cloudy")
        dayLabel.text = model.dateString!
        windLabel.text = String(model.windSpeed!) + "m/s"
        pressureLabel.text = String(model.pressure!) + "hpa"
        let url = URL(string: imageDownloadUrl + model.iconName! + ".png")
        weatherImageView.kf.setImage(with: url)
    }
}
