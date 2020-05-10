//
//  BulletNode.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/5/4.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit

class BulletNode: SKNode {
    var thrust: CGVector = CGVector(dx: 0, dy: 0)
    
    override init() {
        super.init()
        
        let dot = SKLabelNode(fontNamed: "Courier")
        dot.fontColor = SKColor.black
        dot.fontSize = 20
        dot.text = "🗼"
        addChild(dot)
        
        let body = SKPhysicsBody(circleOfRadius: 1)
        body.isDynamic = true
        body.categoryBitMask = PlayerMissileCategory
        body.contactTestBitMask = EnemyCategory
        body.collisionBitMask = EnemyCategory
        body.fieldBitMask = GravityFieldCategory
        body.mass = 0.01
        
        physicsBody = body
        name = "Bullet \(self)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let dx = aDecoder.decodeFloat(forKey: "thrustX")
        let dy = aDecoder.decodeFloat(forKey: "thrustY")
        
        thrust = CGVector(dx: CGFloat(dx), dy: CGFloat(dy))
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(Float(thrust.dx
        ), forKey: "thrustX")
        coder.encode(Float(thrust.dy), forKey: "thrustY")
    }
    
    func applyRecurringForce() {
        physicsBody?.applyForce(thrust)
    }
    
    class func bullet(from start: CGPoint, towards destination: CGPoint) -> BulletNode {
        let bullet = BulletNode()
        
        bullet.position = start
        let movement = vectorBetweenPoints(start, destination)
        let magnitude = vectorLength(movement)
        let scaledMovement = vectorMultiply(movement, 1 / magnitude)
        let thrustMagnitude = CGFloat(100)
        bullet.thrust = vectorMultiply(scaledMovement, thrustMagnitude)
        bullet.run(SKAction.playSoundFileNamed("shoot.wav", waitForCompletion: false))
        
        return bullet
    }
}
