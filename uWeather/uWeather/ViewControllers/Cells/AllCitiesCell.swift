//
//  AllCitiesCell.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/27/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class AllCitiesCell: UITableViewCell {

    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension AllCitiesCell: WeatherDataSourceProtocol {
    func fill(model: WeatherModel) {
        cityNameLabel.text = model.cityName!
        temperatureLabel.text = String(model.temperature!) + degree
    }
}
