//
//  GameOverScene.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/4.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.purple
        let text = SKLabelNode(fontNamed: "Courier")
        text.text = "GameOver"
        text.fontColor = SKColor.white
        text.fontSize = 50
        text.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        addChild(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(3 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            view.presentScene(StartScene(size: self.frame.size), transition: SKTransition.flipVertical(withDuration: 1))
        }
    }
}
