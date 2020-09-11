//
//  BlueViewController.swift
//  PagingDemo
//
//  Created by Robert Ryan on 9/10/20.
//  Copyright © 2020 Robert Ryan. All rights reserved.
//

import UIKit

class BlueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function, "blue")
    }

}
