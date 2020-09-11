//
//  ScrollViewDemoViewController.swift
//  PagingDemo
//
//  Created by Robert Ryan on 9/10/20.
//  Copyright © 2020 Robert Ryan. All rights reserved.
//

import UIKit

class ScrollViewDemoViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    lazy var containerViews: [UIView] = controllers.map { _ in
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }

    let controllers = [RedViewController(), GreenViewController(), BlueViewController()]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.delegate = self

        var previousAnchor: NSLayoutXAxisAnchor = scrollView.contentLayoutGuide.leadingAnchor

        for containerView in containerViews {
            scrollView.addSubview(containerView)
            NSLayoutConstraint.activate([
                containerView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),     // make them the size of the scroll view's frame
                containerView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),

                containerView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),       // and link the top, bottom, and leadinging anchor for each
                containerView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
                containerView.leadingAnchor.constraint(equalTo: previousAnchor)
            ])

            previousAnchor = containerView.trailingAnchor
        }

        containerViews.last?.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true // and add that final constraint for the last container

//        for (index, viewController) in controllers.enumerated() {
//            addChild(viewController)
//            let subview = viewController.view!
//            containerViews[index].addSubview(subview)
//            subview.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                subview.leadingAnchor.constraint(equalTo: containerViews[index].leadingAnchor),
//                subview.trailingAnchor.constraint(equalTo: containerViews[index].trailingAnchor),
//                subview.topAnchor.constraint(equalTo: containerViews[index].topAnchor),
//                subview.bottomAnchor.constraint(equalTo: containerViews[index].bottomAnchor)
//            ])
//        }

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidScroll(scrollView)
    }
}

extension ScrollViewDemoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let rect = CGRect(origin: scrollView.contentOffset, size: scrollView.bounds.size)
        for (index, containerView) in containerViews.enumerated() {
            let controller = controllers[index]
            let controllerView = controller.view!
            if rect.intersects(containerView.frame) {
                if controllerView.superview == nil {
                    addChild(controller)
                    containerView.addSubview(controllerView)

                    NSLayoutConstraint.activate([
                        controllerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                        controllerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                        controllerView.topAnchor.constraint(equalTo: containerView.topAnchor),
                        controllerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                    ])

                    controller.didMove(toParent: self)
                }
            } else {
                if controllerView.superview != nil {
                    controller.willMove(toParent: nil)
                    controllerView.removeFromSuperview()
                    controller.removeFromParent()
                }
            }
        }
    }
}
