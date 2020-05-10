//
//  ViewController.swift
//  TouchExplorer
//
//  Created by Glorin Li on 2020/5/6.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tapsLabel: UILabel!
    @IBOutlet var touchesLabel: UILabel!
    @IBOutlet var forceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func updateLabelsFromTouches(_ touch: UITouch?, allTouches: Set<UITouch>?) {
        let numTaps = touch?.tapCount ?? 0
        tapsLabel.text = "\(numTaps) taps detected"
        
        let numTouches = allTouches?.count ?? 0
        touchesLabel.text = "\(numTouches) touches detected"
        
        if traitCollection.forceTouchCapability == .available {
            forceLabel.text = "Force: \(touch?.force ?? 0)\nMax force: \(touch?.maximumPossibleForce ?? 0)"
        } else {
            forceLabel.text = "3D touch not available"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Began"
        
        updateLabelsFromTouches(touches.first, allTouches: event?.allTouches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Moved"
        
        updateLabelsFromTouches(touches.first, allTouches: event?.allTouches)

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Cancelled"
        
        updateLabelsFromTouches(touches.first, allTouches: event?.allTouches)

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageLabel.text = "Touches Ended"
        
        updateLabelsFromTouches(touches.first, allTouches: event?.allTouches)

    }

}

