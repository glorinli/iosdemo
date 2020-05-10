//
//  ViewController.swift
//  StateLab
//
//  Created by Glorin Li on 2020/4/28.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var label: UILabel!
    private var animate: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let bounds = view.bounds
        
        let labelFrame = CGRect(origin: CGPoint(x: bounds.origin.x, y: bounds.midY - 50), size: CGSize(width: bounds.size.width, height: 100))
        
        label = UILabel(frame: labelFrame)
        label.font = UIFont(name: "Helvetica", size: 70)
        label.text = "星星"
        label.textAlignment = NSTextAlignment.center
        label.backgroundColor = UIColor.clear
        
        view.addSubview(label)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.appWillBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
    }

    func rotateLabelDown() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: {(Bool) -> Void in
            self.rotateLabelUp()
        })
    }
    
    func rotateLabelUp() {
        UIView.animate(withDuration: 0.5, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: 0)
        }, completion: {(Bool) -> Void in
            if self.animate {
                self.rotateLabelDown()
            }
        })
    }
    
    @objc func appWillResignActive() {
        print("VC: \(#function)")
        animate = false
    }
    
    @objc func appWillBecomeActive() {
        print("VC: \(#function)")
        animate = true
        rotateLabelDown()
    }
    
}

