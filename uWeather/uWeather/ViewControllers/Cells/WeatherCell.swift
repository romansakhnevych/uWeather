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
}

extension WeatherCell {
    func fill(model: String) {
        temperatureLabel.text = "15 \u{00B0}"
        weatherImageView.image = UIImage(named: "cloudy")
        dayLabel.text = "Mon"
    }
}
