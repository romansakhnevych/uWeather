//
//  DetailWeatherViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/22/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailWeatherViewController: WeatherDataSourceProtocol {
    func fill(model: WeatherModel) {
        temperatureLabel.text = String(model.temperature!) + degree
        cityLabel.text = model.cityName!
        forecastLabel.text = model.mainWeather!
        windLabel.text = String(model.wind!.speed!) + "m/s, W"
        humidityLabel.text = String(model.humidity!) + "%"
        adviceLabel.text = model.descriptionMessage!
    }
}

extension DetailWeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing:DetailWeatherCell.self), for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let detailCell = cell as! DetailWeatherCell
        if indexPath.row < 10 {
            detailCell.fill(model:"0" + String(indexPath.row) + ":00" )
        } else {
            detailCell.fill(model: String(indexPath.row) + ":00")
        }
    }
}

extension DetailWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 6, height: collectionView.frame.height)
    }
}
