//
//  PlayerNode.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/1.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit

class PlayerNode: SKNode {
    override init() {
        super.init()
        name = "Player \(self)"
        initNodeGraph()
        
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initNodeGraph() {
        let label = SKLabelNode(fontNamed: "Courier")
        label.fontColor = SKColor.darkGray
        label.fontSize = 40
        label.text = "✈"
        label.zRotation = CGFloat(Double.pi / 2)
        label.name = "label"
        self.addChild(label)
    }
    
    func moveToward(_ location: CGPoint) {
        removeAction(forKey: "movement")
        removeAction(forKey: "wobbling")
        
        let distance = pointDistance(position, location)
        let screenWidth = UIScreen.main.bounds.size.width
        let duration = TimeInterval(2 * distance / screenWidth)
        
        run(SKAction.move(to: location, duration: duration), withKey: "movement")
        
        let wobbleTime = 0.3
        let halfWobbleTime = wobbleTime / 2
        let wobbling = SKAction.sequence([
            SKAction.scale(to: 0.8, duration: halfWobbleTime),
            SKAction.scale(to: 1, duration: halfWobbleTime)])
        
        let wobbleCount = Int(duration / wobbleTime)
        run(SKAction.repeat(wobbling, count: wobbleCount), withKey: "wobbling")
    }
    
    private func initPhysicsBody() {
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 20))
        body.affectedByGravity = false
        body.categoryBitMask = PlayerCategory
        body.contactTestBitMask = EnemyCategory
        body.collisionBitMask = 0
        body.fieldBitMask = 0
        physicsBody = body
    }
    
    override func receiveAttacker(_ attacker: SKNode, contact: SKPhysicsContact) {
        playExplosion(contact.contactPoint)
        
        self.run(SKAction.playSoundFileNamed("playerHit.wav", waitForCompletion: false))
    }
    
    func playExplosion(_ position: CGPoint) {
       let explosion = SKEmitterNode(fileNamed: "EnemyExplosion.sks")!
        explosion.numParticlesToEmit = 50
        explosion.position = position
        scene?.addChild(explosion)
    }
}
