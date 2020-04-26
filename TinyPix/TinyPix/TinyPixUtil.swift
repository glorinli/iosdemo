//
//  TinyPixUtil.swift
//  TinyPix
//
//  Created by Glorin Li on 2020/4/23.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class TinyPixUtil {
    class func getTintColorForIndex(index: Int) -> UIColor {
        switch index {
        case 0:
            return UIColor.red
        case 1:
            return UIColor.green
        case 2:
            return UIColor.blue
        default:
            return UIColor.red
        }
    }
}
