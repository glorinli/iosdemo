//
//  StartScene.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/5.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit

class StartScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.green
        
        let topLabel = SKLabelNode(fontNamed: "Courier")
        topLabel.text = "Text Shooter"
        topLabel.fontSize = 48
        topLabel.position = CGPoint(x: frame.width / 2, y: frame.height * 0.7)
        addChild(topLabel)
        
        let bottomLabel = SKLabelNode(fontNamed: "Courier")
        bottomLabel.text = "Tap anywhere to start"
        bottomLabel.fontSize = 20
        bottomLabel.position = CGPoint(x: frame.width / 2, y: frame.height * 0.3)
        addChild(bottomLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.doorway(withDuration: 1)
        let game = GameScene(size: frame.size)
        view?.presentScene(game, transition: transition)
        
        self.run(SKAction.playSoundFileNamed("gameStart.wav", waitForCompletion: false))
    }
}
