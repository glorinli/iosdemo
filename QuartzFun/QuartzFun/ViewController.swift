//
//  ViewController.swift
//  QuartzFun
//
//  Created by Glorin Li on 2020/4/29.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorControl: UISegmentedControl!
    @IBOutlet weak var shapeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeColor(_ sender: UISegmentedControl) {
        let drawingColorSelection = DrawingColor(rawValue: Int(sender.selectedSegmentIndex))
        
        if let drawingColor = drawingColorSelection {
            let funView = view as! QuartzFunView
            switch drawingColor {
            case .red:
                funView.currentColor = UIColor.red
                funView.useRandomColor = false
            case .blue:
                funView.currentColor = UIColor.blue
                funView.useRandomColor = false
            case .green:
                funView.currentColor = UIColor.green
                funView.useRandomColor = false
            case .yellow:
                funView.currentColor = UIColor.yellow
                funView.useRandomColor = false
            case .random:
                funView.currentColor = UIColor.randomColor()
                funView.useRandomColor = true
            default:
                funView.currentColor = UIColor.red
                funView.useRandomColor = false
            }
        }
    }
    @IBAction func changeShape(_ sender: UISegmentedControl) {
        let shapeSelection = Shape(rawValue: Int(sender.selectedSegmentIndex))
        
        
        if let shape = shapeSelection {
            let funView = view as! QuartzFunView
            funView.shape = shape
            colorControl.isHidden = shape == Shape.image
        }
    }
    
}

