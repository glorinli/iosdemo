//
//  ViewController.swift
//  Orientations
//
//  Created by Glorin Li on 2019/9/8.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue:
            (UIInterfaceOrientationMask.portrait.rawValue |
        UIInterfaceOrientationMask.landscapeLeft.rawValue))
    }
}

