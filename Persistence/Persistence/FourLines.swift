//
//  FourLines.swift
//  Persistence
//
//  Created by Glorin Li on 2020/4/8.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import Foundation

class FourLines : NSObject, NSCoding, NSCopying {
    private static let linesKey = "linesKey"
    var lines: [String]?
    
    override init() {}
    
    func encode(with coder: NSCoder) {
        if let saveLines = lines {
            coder.encode(saveLines, forKey: FourLines.linesKey)
        }
    }
    
    required init?(coder: NSCoder) {
        lines = coder.decodeObject(forKey: FourLines.linesKey) as? [String]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = FourLines()
        
        if let linesToCopy = lines {
            var newLines = Array<String>()
            for line in linesToCopy {
                newLines.append(line)
            }
            
            copy.lines = newLines
        }
        
        return copy
    }
    
    
}
