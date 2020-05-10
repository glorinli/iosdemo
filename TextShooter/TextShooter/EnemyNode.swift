//
//  EnemyNode.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/2.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit

class EnemyNode: SKNode {
    override init() {
        super.init()
        name = "Enemy \(self)"
        initNodeGraph()
        
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func initNodeGraph() {
        let topRow = SKLabelNode(fontNamed: "Courier-Bold")
        topRow.fontColor = SKColor.brown
        topRow.fontSize = 20
        topRow.text = "x x"
        topRow.position = CGPoint(x: 0, y: 15)
        self.addChild(topRow)
        
        let midRow = SKLabelNode(fontNamed: "Courier-Bold")
        midRow.fontColor = SKColor.brown
        midRow.fontSize = 20
        midRow.text = "x"
        self.addChild(midRow)
        
        let bottomRow = SKLabelNode(fontNamed: "Courier-Bold")
        bottomRow.fontColor = SKColor.brown
        bottomRow.fontSize = 20
        bottomRow.text = "x x"
        bottomRow.position = CGPoint(x: 0, y: -15)
        self.addChild(bottomRow)
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
        let body = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 40))
        body.affectedByGravity = false
        body.categoryBitMask = EnemyCategory
        body.contactTestBitMask = PlayerCategory | EnemyCategory
        body.mass = 0.2
        body.angularDamping = 0
        body.linearDamping = 0
        body.fieldBitMask = 0
        physicsBody = body
    }
    
    override func friendlyBumpFrom(_ node: SKNode) {
        physicsBody?.affectedByGravity = true
    }
    
    override func receiveAttacker(_ attacker: SKNode, contact: SKPhysicsContact) {
        physicsBody?.affectedByGravity = true
        let force = vectorMultiply(attacker.physicsBody!.velocity, contact.collisionImpulse)
        
        let myContact = scene!.convert(contact.contactPoint, to: self)
        physicsBody?.applyForce(force, at: myContact)
        
        let explosion = SKEmitterNode(fileNamed: "MissileExplosion.sks")!
        explosion.numParticlesToEmit = 20
        explosion.position = contact.contactPoint
        scene?.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("enemyHit.wav", waitForCompletion: false))
    }
}
