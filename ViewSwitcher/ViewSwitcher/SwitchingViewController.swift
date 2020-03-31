//
//  ViewController.swift
//  ViewSwitcher
//
//  Created by Glorin Li on 2019/9/20.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class SwitchingViewController: UIViewController {
    private var blueVC: BlueViewController!
    private var yellowVC: YellowViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        blueVC = storyboard?.instantiateViewController(withIdentifier: "Blue") as! BlueViewController
        blueVC.view.frame = view.frame
        switchViewController(from: nil, to: blueVC)
    }
    
    

    @IBAction func switchViews(sender: UIBarButtonItem) {
        // Create the new view controller, if required
        if yellowVC?.view?.superview == nil {
            if yellowVC == nil {
                yellowVC = storyboard?.instantiateViewController(withIdentifier: "Yellow")
                as! YellowViewController
            }
        } else if blueVC?.view?.superview == nil {
            if blueVC == nil {
                blueVC = storyboard?.instantiateViewController(withIdentifier: "Blue")
                as! BlueViewController
            }
        }
        
        UIView.beginAnimations("View Flip", context: nil)
        UIView.setAnimationDuration(0.4)
        UIView.setAnimationCurve(.easeInOut)
        
        // Switch
        if blueVC != nil && blueVC!.view.superview != nil {
            UIView.setAnimationTransition(.flipFromRight, for: view, cache: true)
            yellowVC.view.frame = view.frame
            switchViewController(from: blueVC, to: yellowVC)
        } else {
            UIView.setAnimationTransition(.flipFromLeft, for: view, cache: true)
            blueVC.view.frame = view.frame
            switchViewController(from: yellowVC, to: blueVC)
        }
        
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if blueVC != nil && blueVC.view.superview == nil {
            blueVC = nil
        }
        
        if yellowVC != nil && yellowVC.view.superview == nil {
            yellowVC = nil
        }
    }
    
    private func switchViewController(from fromVC: UIViewController?,
                                      to toVC: UIViewController?) {
        if fromVC != nil {
            fromVC!.willMove(toParent: nil)
            fromVC!.view.removeFromSuperview()
            fromVC!.removeFromParent()
        }
        
        if toVC != nil {
            self.addChild(toVC!)
            self.view.insertSubview(toVC!.view, at: 0)
            toVC!.didMove(toParent: self)
        }
    }
}

