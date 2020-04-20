//
//  ViewController.swift
//  CoreDataPersistence
//
//  Created by Glorin Li on 2020/4/18.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet var lineFieds: [UITextField]!
    
    private static let lineEntityName = "Line"
    private static let lineNumberKey = "lineNumber"
    private static let lineTextKey = "lineText"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ViewController.lineEntityName)
        
        do {
            let objects = try context.fetch(request) as! [Line]
            
            for object in objects {
                let lineNum: Int = object.value(forKey: ViewController.lineNumberKey)! as! Int
                let lineText: String = object.value(forKey: ViewController.lineTextKey)! as? String ?? ""
                lineFieds[lineNum].text = lineText
            }
            
            // Listen app inactive
            NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: UIApplication.shared)
        } catch {
            print("Fail to request \(error)")
        }
    }

    @objc func applicationWillResignActive(notification: NSNotification) {
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        
        for i in 0 ..< lineFieds.count {
            let textField = lineFieds[i]
            
            let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: ViewController.lineEntityName)
            request.predicate = NSPredicate(format: "%K = %d", ViewController.lineNumberKey, i)
            
            do {
                let objects = try context.fetch(request)
                var theLine: NSManagedObject! = objects.first as? NSManagedObject
                if theLine == nil {
                    // Insert
                    theLine = NSEntityDescription.insertNewObject(forEntityName: ViewController.lineEntityName, into: context) as NSManagedObject
                }
                
                theLine.setValue(i, forKey: ViewController.lineNumberKey)
                theLine.setValue(textField.text, forKey: ViewController.lineTextKey)
            } catch {
                print("Fail to request \(error)")
            }
        }
    }

}

