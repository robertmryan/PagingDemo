//
//  PageViewController.swift
//  PagingDemo
//
//  Created by Robert Ryan on 9/10/20.
//  Copyright © 2020 Robert Ryan. All rights reserved.
//

import UIKit

class PageViewControllerDemoViewController: UIPageViewController {
    let controllers = [RedViewController(), GreenViewController(), BlueViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewControllerDemoViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(where: { $0 == viewController }), index < (controllers.count - 1) {
            return controllers[index + 1]
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(where: { $0 == viewController }), index > 0 {
            return controllers[index - 1]
        }
        return nil
    }
}
