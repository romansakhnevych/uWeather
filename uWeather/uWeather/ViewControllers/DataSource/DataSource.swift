//
//  DataSource.swift
//  uWeather
//
//  Created by Pavlo Ivanov on 3/28/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import Foundation

protocol WeatherDataSourceProtocol {
    func fill(model: WeatherModel)
}
