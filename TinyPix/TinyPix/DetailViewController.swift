//
//  DetailViewController.swift
//  TinyPix
//
//  Created by Glorin Li on 2020/4/21.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var pixView: TinyPixView!
    
    @objc func onSettingsChanged(notification: Notification) {
        updateTintColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        updateTintColor()
        NotificationCenter.default.addObserver(self, selector: #selector(self.onSettingsChanged(notification:)), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }

    var detailItem: TinyPixDocument? {
        didSet {
            if (isViewLoaded) {
                pixView.document = detailItem
                pixView.setNeedsDisplay()
            }
        }
    }

    private func updateTintColor() {
        let prefs = UserDefaults.standard
        let selectedColorIndex = prefs.integer(forKey: "selectedColorIndex")
        let tintColor = TinyPixUtil.getTintColorForIndex(index: selectedColorIndex)
        pixView.tintColor = tintColor
        pixView.setNeedsDisplay()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let doc = detailItem {
//            doc.close(completionHandler: nil)
            doc.autosave(completionHandler: nil)
            
            NSLog("Close document when view disappear")
        }
    }

}

