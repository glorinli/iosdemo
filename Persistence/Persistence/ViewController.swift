//
//  ViewController.swift
//  Persistence
//
//  Created by Glorin Li on 2020/4/7.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let fileURL = dataFileURL()
        
        if (FileManager.default.fileExists(atPath: fileURL.path)) {
            if let array = NSArray(contentsOf: fileURL as URL) as? [String] {
                for i in 0..<array.count {
                    if i < lineFields.count {
                        lineFields[i].text = array[i]
                    }
                }
            }
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: app)
    }
    
    @objc func applicationWillResignActive(notification: NSNotification) {
        NSLog("applicationWillResignActive")
        
        let fileUrl = dataFileURL()
        let array = (lineFields as NSArray).value(forKey: "text") as! NSArray
        array.write(to: fileUrl as URL, atomically: true)
    }

    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        var url: URL?
        url = URL(fileURLWithPath: "")
        
        do {
            try url = urls.first!.appendingPathComponent("data.plist")
        } catch {
            print("Error is \(error)")
        }
        
        return url!
    }

}

