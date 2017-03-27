//
//  AllCitiesViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/27/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class AllCitiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        tableView.rowHeight = 110
    }
}
