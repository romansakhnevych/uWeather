//
//  AllCitiesViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/27/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

protocol AllCitiesViewControllerDelegate: class {
    func viewComtroller(viewController: AllCitiesViewController, didSelecteWeather weatherModel: WeatherModel)
}

class AllCitiesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    weak var delegate: AllCitiesViewControllerDelegate?
    var favorite: [WeatherModel]?
    let weatherServices = WeatherServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        tableView.rowHeight = 110
        tableView.sectionFooterHeight = 0.001
    }
    
    func getWeather(city: String) {
        weatherServices.getWeather(city: city, success: { (weather) in
            self.favorite!.append(weather)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    
}

extension AllCitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:AllCitiesCell.self), for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cityCell = cell as! WeatherDataSourceProtocol
        cityCell.fill(model: self.favorite![indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.viewComtroller(viewController: self, didSelecteWeather: self.favorite![indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}

extension AllCitiesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getWeather(city: textField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.text = "Find Your City"
    }
}
