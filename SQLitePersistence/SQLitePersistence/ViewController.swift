//
//  ViewController.swift
//  SQLitePersistence
//
//  Created by Glorin Li on 2020/4/9.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineFields: [UITextField]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Open db
        var database: OpaquePointer? = nil
        let path = dataFilePath()
        var result = sqlite3_open(path, &database)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Fail to open data base: \(path)")
            return
        }
        
        // create table if not exists
        let createSQL = "create table if not exists fields " +
            "(row integer primary key, field_data text)"
        var errMsg: UnsafeMutablePointer<Int8>? = nil
        result = sqlite3_exec(database, createSQL, nil, nil, &errMsg)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Fail to create table")
            return
        }
        
        // Query data
        let query = "Select row, field_data from fields order by row"
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let row = Int(sqlite3_column_int(statement, 0))
                let rowData = sqlite3_column_text(statement, 1)
                print("Row data of index \(row) is \(rowData)")
                let fieldValue = rowData == nil ? "" : String.init(cString: UnsafePointer<UInt8>(rowData!))
                lineFields[row].text = fieldValue
            }
            
            sqlite3_finalize(statement)
        }
        
        sqlite3_close(database)
        
        // Listen app inactive
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: UIApplication.shared)
        
    }

    func dataFilePath() -> String {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        var url: String?
        url = ""
        
        do {
            try url = urls.first?.appendingPathComponent("data.db").path
        } catch {
            print("Error get file path \(error)")
        }
        
        return url!
    }
    
    @objc func applicationWillResignActive(notification: NSNotification) {
        // Open db
        var database: OpaquePointer? = nil
        let path = dataFilePath()
        var result = sqlite3_open(path, &database)
        
        if result != SQLITE_OK {
            sqlite3_close(database)
            print("Fail to open data base: \(path)")
            return
        }
        
        // Write data
        for i in 0..<lineFields.count {
            let field = lineFields[i]
            
            let update = "insert or replace into fields (row, field_data) values (?, ?)"
            var statement: OpaquePointer? = nil
            if sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK {
                let text = field.text
                sqlite3_bind_int(statement, 1, Int32(i))
                sqlite3_bind_text(statement, 2, text, -1, nil)
            }
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error update database")
                sqlite3_close(database)
                return
            }
            
            sqlite3_finalize(statement)
        }
        
        sqlite3_close(database)
    }

}

