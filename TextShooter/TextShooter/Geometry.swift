//
//  Geometry.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/2.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

func pointDistance(_ p1: CGPoint, _ p2: CGPoint) -> CGFloat {
    return CGFloat(sqrtf(powf(Float(p2.x - p1.x), 2) + powf(Float(p2.y - p1.y), 2)))
}

func vectorMultiply(_ v: CGVector, _ m: CGFloat) -> CGVector {
    return CGVector(dx: v.dx * m, dy: v.dy * m)
}

func vectorBetweenPoints(_ p1: CGPoint, _ p2: CGPoint) -> CGVector {
    return CGVector(dx: p2.x - p1.x, dy: p2.y - p1.y)
}

func vectorLength(_ v: CGVector) -> CGFloat {
    
    return CGFloat(sqrtf(powf(Float(v.dx), 2) + powf(Float(v.dy), 2)))
}
