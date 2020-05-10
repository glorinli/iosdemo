//
//  ViewController.swift
//  Swipes
//
//  Created by Glorin Li on 2020/5/7.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    private var gestureStartPoint: CGPoint!
    private static let minimumGestureLength = Float(25)
    private static let maximunVariance = Float(5)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            gestureStartPoint = touch.location(in: self.view)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let gestureStartPoint = self.gestureStartPoint {
            let currentPosition = touch.location(in: self.view)
            
            let dx = fabsf(Float(gestureStartPoint.x - currentPosition.x))
            let dy = fabsf(Float(gestureStartPoint.y - currentPosition.y))
            
            if dx >= ViewController.minimumGestureLength && dy < ViewController.maximunVariance {
                showTip("Horizontal swipe detected")
            } else if dy > ViewController.minimumGestureLength && dx < ViewController.maximunVariance {
                showTip("Vertical swipe detected")
            }
        }
    }
    
    private func showTip(_ tip: String) {
        label.text = tip
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            self.label.text = ""
        }
    }
}

