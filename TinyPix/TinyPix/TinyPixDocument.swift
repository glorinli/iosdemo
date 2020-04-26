//
//  TinyPixDocument.swift
//  TinyPix
//
//  Created by Glorin Li on 2020/4/21.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit

class TinyPixDocument: UIDocument {
    private var bitmap: [UInt8]
    private var modified: Bool = false
    
    override init(fileURL url: URL) {
        bitmap = [0x01, 0x2, 0x4, 0x8, 0x10, 0x20, 0x40, 0x80]
        super.init(fileURL: url)
    }
    
    func stateAt(row: Int, column: Int) -> Bool {
        let rowByte = bitmap[row]
        let result = UInt8(1 << column) & rowByte
        return result != 0
    }
    
    func setState(state: Bool, row: Int, column: Int) {
        var rowByte = bitmap[row]
        
        if state {
            rowByte |= UInt8(1 << column)
        } else {
            rowByte &= ~UInt8(1 << column)
        }
        
        bitmap[row] = rowByte
        
        modified = true
    }
    
    func toggleState(row: Int, colunm: Int) {
        let state = stateAt(row: row, column: colunm)
        setState(state: !state, row: row, column: colunm)
    }
    
    override var hasUnsavedChanges: Bool {
        return modified
    }
    
    override func contents(forType typeName: String) throws -> Any {
        NSLog("Save document forType \(typeName)")
        modified = false
        return Data(bytes: UnsafePointer<UInt8>(bitmap), count: bitmap.count)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let bitmapData = contents as? NSData {
            bitmapData.getBytes(UnsafeMutablePointer<UInt8>(mutating: bitmap), length: bitmap.count)
            NSLog("Load document")
        }
    }
}
