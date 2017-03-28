//
//  DeatailWeatherCell.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/27/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class DetailWeatherCell: UICollectionViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
}

extension DetailWeatherCell {
    func fill(model: String) {
        timeLabel.text = model
        temperatureLabel.text = "5" + degree
    }
}
