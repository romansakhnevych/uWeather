//
//  BaseViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/21/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        attachCustomBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup ui
    func attachCustomBackground() {
        let backgroundImage = UIImage.init(named:"Background")
        UIGraphicsBeginImageContext(view.frame.size)
        backgroundImage?.draw(in: view.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor.init(patternImage: image!)
    }

}
