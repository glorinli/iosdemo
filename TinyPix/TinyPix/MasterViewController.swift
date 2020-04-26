//
//  MasterViewController.swift
//  TinyPix
//
//  Created by Glorin Li on 2020/4/21.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    @IBOutlet var colorControl: UISegmentedControl!
    private var documentFileURLs: [URL] = []
    private var chosenDocument: TinyPixDocument?
    
    private func urlForFileName(fileName: String) -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        var url: URL = URL(fileURLWithPath: "")
        
        do {
            try url = urls.first!.appendingPathComponent(fileName)
        } catch {
            print("Fail to get url \(error)")
        }
        
        return url
    }
    
    private func reloadFiles() {
        let fm: FileManager = FileManager.default
        let documentsUrl = fm.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileUrls = try fm.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            
            let sortedFiles = fileUrls.sorted(by: {(url1, url2) -> Bool in
                let attr1 = try! fm.attributesOfItem(atPath: url1.path)
                let attr2 = try! fm.attributesOfItem(atPath: url2.path)
                
                let date1 = attr1[FileAttributeKey.modificationDate] as! NSDate
                let date2 = attr2[FileAttributeKey.modificationDate] as! NSDate
                
                return date1.compare(date2 as Date) == ComparisonResult.orderedAscending
                })
            
            documentFileURLs = sortedFiles
            tableView.reloadData()
        } catch {
            print("Error listing dir \(error)")
        }
    }
    
    // TableView source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documentFileURLs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell")!
        let fileUrl = documentFileURLs[indexPath.row]
        
        do {
            try cell.textLabel?.text = fileUrl.deletingPathExtension().lastPathComponent
        } catch {
            cell.textLabel?.text = "Fail to show \(error)"
        }
        
        return cell
    }
    
    @IBAction func chooseColor(sender: UISegmentedControl) {
        let selectedColorIndex = sender.selectedSegmentIndex
        setTintColorForIndex(colorIndex: selectedColorIndex)
        
        let prefs = UserDefaults.standard
        prefs.set(selectedColorIndex, forKey: "selectedColorIndex")
        prefs.synchronize()
        
        NSLog("chooseColor, index = %d", selectedColorIndex)
    }
    
    private func setTintColorForIndex(colorIndex: Int) {
        colorControl.tintColor = TinyPixUtil.getTintColorForIndex(index: colorIndex)
    }
    
    @objc func insertNewObject() {
        let alert = UIAlertController(title: "Choose File Name", message: "Enter a name for you new TinyPix document", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let createAction = UIAlertAction(title: "Create", style: .default, handler: {action in
            let textFields = alert.textFields![0] as UITextField
            if textFields.text != nil {
                self.createFileNamed(name: textFields.text!)
            }
        })
        
        alert.addAction(cancelAction)
        alert.addAction(createAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func createFileNamed(name: String) {
        let trimmedFileName = name.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if !trimmedFileName.isEmpty {
            let target = trimmedFileName + ".tinypix"
            let saveUrl = urlForFileName(fileName: target)
            chosenDocument = TinyPixDocument(fileURL: saveUrl)
            chosenDocument?.save(to: saveUrl, for: .forCreating, completionHandler: {success in
                if success {
                    print("Save ok")
                    self.reloadFiles()
                    self.performSegue(withIdentifier: "masterToDetail", sender: self)
                } else {
                    print("Fail to save")
                }
            })
        }
    }
    
    // Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add
            , target: self, action: #selector(MasterViewController.insertNewObject))
        navigationItem.rightBarButtonItem = addButton
        
        let prefs = UserDefaults.standard
        let selectedColorIndex = prefs.integer(forKey: "selectedColorIndex")
        setTintColorForIndex(colorIndex: selectedColorIndex)
        colorControl.selectedSegmentIndex = selectedColorIndex
        
        reloadFiles()
    }
    
    // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! UINavigationController
        let detailVC = dest.topViewController as! DetailViewController
        
        if sender as AnyObject? === self {
            detailVC.detailItem = chosenDocument
        } else {
            if let indexPath = tableView.indexPathForSelectedRow {
                let docUrl = documentFileURLs[indexPath.row]
                chosenDocument = TinyPixDocument(fileURL: docUrl)
                chosenDocument?.open() {success in
                    if success {
                        detailVC.detailItem = self.chosenDocument
                    } else {
                        print("Fail to load")
                    }
                }
            }
        }
    }
}

