//
//  ViewController.swift
//  Button Fun
//
//  Created by Glorin Li on 2019/9/3.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBAction func buttonPressed(_ sender: UIButton) {
        let title = sender.title(for: .selected)!
        let text = "\(title) button pressed"
        let styledText = NSMutableAttributedString(string: text)
        let attributes = [
            NSAttributedString.Key.font:
                UIFont.boldSystemFont(ofSize: statusLabel.font.pointSize),
            NSAttributedString.Key.foregroundColor:
                UIColor.red,
            NSAttributedString.Key.strokeColor: UIColor.green
        ]
        let nameRange = (text as NSString).range(of: title)
        styledText.setAttributes(attributes as [NSAttributedString.Key : Any], range: nameRange)
        
        statusLabel.attributedText = styledText
    }
}

