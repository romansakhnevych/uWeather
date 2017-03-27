//
//  ContainerViewController.swift
//  uWeather
//
//  Created by Roman Sakhnievych on 3/21/17.
//  Copyright © 2017 Roman Sakhnievych. All rights reserved.
//

import UIKit

class ContainerViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIi()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Setup
    private func setupUIi() {
        pageControl.numberOfPages = 2
        setupChildViewControllers()
    }
    
    private func setupChildViewControllers() {
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: view.frame.height - 20)
        viewControllers.append(addChildViewController(identifier: String(describing: WeatherViewController.self)))
        viewControllers.append(addChildViewController(identifier: String(describing: DetailWeatherViewController.self)))
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
}

extension ContainerViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = (scrollView.contentOffset.x / scrollView.frame.width)
        self.pageControl.currentPage = Int(page)
    }
}
