//
//  ContainerViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/21/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

let toAllCitiesSegueIdentifier = "toAllCitiesSegueIdentifier"

class ContainerViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var weatherModel: WeatherModel?
    var favorite = [WeatherModel]()
    
    var viewControllers = [WeatherDataSourceProtocol]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ws = WeatherServices()
        ws.getWeather(city: "Lviv", success: { (weatherModel) in
            self.weatherModel = weatherModel
            self.favorite.append(weatherModel)
            DispatchQueue.main.async {
                self.fillChildViewControllers(model: weatherModel)
            }
        }) { (error) in
            
        }
        setupUIi()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fillChildViewControllers(model: WeatherModel) {
        for viewController in self.viewControllers {
            viewController.fill(model: model)
        }
    }
    
    //MARK: - Setup
    private func setupUIi() {
        pageControl.numberOfPages = 2
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: view.frame.height - 20)
        viewControllers.append(addChildViewController(identifier: String(describing: WeatherViewController.self)) as! WeatherDataSourceProtocol)
        viewControllers.append(addChildViewController(identifier: String(describing: DetailWeatherViewController.self)) as! WeatherDataSourceProtocol)
    }
    
    private func addChildViewController(identifier: String) -> UIViewController {
        let viewController = storyboard?.instantiateViewController(withIdentifier: identifier)
        viewController!.view.backgroundColor = UIColor.clear
        addChildViewController(viewController!)
        if identifier == String(describing: DetailWeatherViewController.self) {
            viewController?.view.frame = CGRect(x: view.bounds.width, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height)
        } else {
            viewController!.view.frame = view.bounds
        }
        scrollView.layoutIfNeeded()
        scrollView.addSubview(viewController!.view)
        viewController!.didMove(toParentViewController: self)
        return viewController!
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toAllCitiesSegueIdentifier {
            let viewController = segue.destination as! AllCitiesViewController
            viewController.favorite = self.favorite
            viewController.delegate = self
        }
    }
}

extension ContainerViewController: AllCitiesViewControllerDelegate {
    func viewComtroller(viewController: AllCitiesViewController, didSelecteWeather weatherModel: WeatherModel) {
        self.favorite.append(weatherModel)
        self.fillChildViewControllers(model: weatherModel)
    }
}

extension ContainerViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = (scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = Int(page)
    }
}
