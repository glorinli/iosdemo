//
//  DevilEnemyNode.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/6.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit

class DevilEnemyNode: EnemyNode {
    override func initNodeGraph() {
        let topRow = SKLabelNode(fontNamed: "Courier-Bold")
        topRow.fontColor = SKColor.brown
        topRow.fontSize = 40
        topRow.text = "😈"
        self.addChild(topRow)
    }

}
