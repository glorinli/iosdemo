//
//  QuartzFunView.swift
//  QuartzFun
//
//  Created by Glorin Li on 2020/4/29.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let red = CGFloat(Double(arc4random_uniform(255)) / 255)
        let green = CGFloat(Double(arc4random_uniform(255)) / 255)
        let blue = CGFloat(Double(arc4random_uniform(255)) / 255)

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}

enum Shape: Int {
    case line = 0, rect, ellipse, image
}

enum DrawingColor: Int {
    case red = 0, blue, yellow, green, random
}

class QuartzFunView: UIView {
    var shape = Shape.line
    var currentColor = UIColor.red
    var useRandomColor = false
    
    // Internal properties
    private let image = UIImage(named: "iphone")
    private var firstTouchLocation = CGPoint.zero
    private var lastTouchLocation = CGPoint.zero
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if useRandomColor {
                currentColor = UIColor.randomColor()
            }
            
            firstTouchLocation = touch.location(in: self)
            lastTouchLocation = firstTouchLocation
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location(in: self)
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastTouchLocation = touch.location(in: self)
            setNeedsDisplay()
        }
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        guard context != nil else {
            return
        }
        
        context?.setLineWidth(2.0)
        context?.setStrokeColor(currentColor.cgColor)
        context?.setFillColor(currentColor.cgColor)
        
        let currentRect = CGRect(x: firstTouchLocation.x,
                                 y: firstTouchLocation.y,
                                 width: lastTouchLocation.x - firstTouchLocation.x,
                                 height: lastTouchLocation.y - firstTouchLocation.y)
        
        switch shape {
        case .line:
            context?.move(to: firstTouchLocation)
            context?.addLine(to: lastTouchLocation)
            context?.strokePath()
        case .rect:
            context?.addRect(currentRect)
            context?.drawPath(using: .fillStroke)
            break
        case .ellipse:
            context?.addEllipse(in: currentRect)
            context?.drawPath(using: .fillStroke)
            break
        case .image:
            let hOffset = image!.size.width / 2
            let vOffset = image!.size.height / 2
            let drawPoint = CGPoint(x: lastTouchLocation.x - hOffset,
                                    y: lastTouchLocation.y - vOffset)
            image!.draw(at: drawPoint)
            break
        }
    }

}
