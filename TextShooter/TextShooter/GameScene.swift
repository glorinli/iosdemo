//
//  GameScene.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/4/30.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var levelNumber: Int
    private var playerLives: Int {
        didSet {
            if let lives = childNode(withName: "LivesLabel") as? SKLabelNode {
                lives.text = "Lives: \(playerLives)"
            }
        }
    }
    private var finished = false
    
    private let playerNode = PlayerNode()
    private let enemies = SKNode()
    private let playerBullets = SKNode()
    
    class func scene(size: CGSize, levelNumber: Int) -> GameScene {
        return GameScene(size: size, levelNumber: levelNumber)
    }
    
    override convenience init(size: CGSize) {
        self.init(size: size, levelNumber: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        levelNumber = aDecoder.decodeInteger(forKey: "level")
        playerLives = aDecoder.decodeInteger(forKey: "playerLives")
        super.init(coder: aDecoder)
    }
    
    init(size: CGSize, levelNumber: Int) {
        self.levelNumber = levelNumber
        self.playerLives = 5
        super.init(size: size)
        
        backgroundColor = SKColor.lightGray
        
        let lives = SKLabelNode(fontNamed: "Courier")
        lives.fontSize = 16
        lives.fontColor = SKColor.black
        lives.name = "LivesLabel"
        lives.text = "Lives: \(playerLives)"
        lives.verticalAlignmentMode = .top
        lives.horizontalAlignmentMode = .right
        lives.position = CGPoint(x: frame.size.width, y: frame.size.height)
        
        addChild(lives)
        
        let level = SKLabelNode(fontNamed: "Courier")
        level.fontSize = 16
        level.fontColor = SKColor.black
        level.name = "LevelLabel"
        level.text = "Level: \(levelNumber)"
        level.verticalAlignmentMode = .top
        level.horizontalAlignmentMode = .left
        level.position = CGPoint(x: 0, y: frame.size.height)
        
        addChild(level)
        
        playerNode.position = CGPoint(x: frame.midX, y: frame.height * 0.1)
        addChild(playerNode)
        
        addChild(enemies)
        spawnEnemies()
        
        addChild(playerBullets)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        physicsWorld.contactDelegate = self
    }
    
    private func spawnEnemies() {
        let count = Int(log(Float(levelNumber))) + levelNumber
        
        for i in 0..<count {
            let enemy = i % 2 == 0 ? EnemyNode() : DevilEnemyNode()
            let size = frame.size
            let x = arc4random_uniform(UInt32(size.width * 0.8)) + UInt32(size.width * 0.1)
            let y = arc4random_uniform(UInt32(size.height * 0.5)) + UInt32(size.height * 0.5)
            
            enemy.position = CGPoint(x: CGFloat(x), y: CGFloat(y))
            enemies.addChild(enemy)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { let location = t.location(in: self)
            if location.y < frame.height * 0.2 {
                let target = CGPoint(x: location.x, y: playerNode.position.y)
                playerNode.moveToward(target)
            } else {
                playerBullets.addChild(BulletNode.bullet(from: playerNode.position, towards: location))
            }
        }
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(Int(levelNumber),forKey: "level")
        coder.encode(Int(playerLives), forKey: "playerLives")
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateBullets()
        updateEnemies()
        
        if !checkGameOver() {
            checkForNextLevel()
        }
    }
    
    private func checkGameOver() -> Bool {
        if playerLives <= 0 {
            triggerGameOver()
            return true
        }
        
        return false
    }
    
    private var bulletsToRemove: [BulletNode] = []
    private func updateBullets() {
        bulletsToRemove.removeAll()
        for bullet in playerBullets.children as! [BulletNode] {
            if !frame.contains(bullet.position) {
                bulletsToRemove.append(bullet)
                continue
            }
            
            bullet.applyRecurringForce()
        }
        
        playerBullets.removeChildren(in: bulletsToRemove)
    }
    
    private var enemiesToRemove: [SKNode] = []
    private func updateEnemies() {
        enemiesToRemove.removeAll()
        
        for node in enemies.children {
            if !frame.contains(node.position) {
                enemiesToRemove.append(node)
            }
        }
        
        enemies.removeChildren(in: enemiesToRemove)
    }
    
    private func checkForNextLevel() {
        if enemies.children.isEmpty {
            gotoNextLevel()
        }
    }
    
    private func gotoNextLevel() {
        finished = true
        
        let label = SKLabelNode(fontNamed: "Courier")
        label.text = "Level Complete!"
        label.fontColor = SKColor.blue
        label.fontSize = 32
        label.position = CGPoint(x: frame.size.width * 0.5, y: frame.size.height * 0.5)
        
        addChild(label)
        
        let nextLevel = GameScene(size: frame.size, levelNumber: levelNumber + 1)
        view!.presentScene(nextLevel, transition: SKTransition.flipHorizontal(withDuration: 1))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == contact.bodyB.categoryBitMask {
            // Same category
            let nodeA = contact.bodyA.node
            let nodeB = contact.bodyB.node
            
            if let a = nodeA, let b = nodeB {
                a.friendlyBumpFrom(b)
                b.friendlyBumpFrom(a)
            }
        } else {
            var attacker: SKNode?
            var attackee: SKNode?
            
            if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
                attacker = contact.bodyA.node
                attackee = contact.bodyB.node
            } else {
                attacker = contact.bodyB.node
                attackee = contact.bodyA.node
            }
            
            if attackee is PlayerNode {
                playerLives -= 1
            }
            
            if let atk = attacker, let ate = attackee {
                ate.receiveAttacker(atk, contact: contact)
                playerBullets.removeChildren(in: [atk])
                enemies.removeChildren(in: [atk])
            }
        }
    }
    
    func triggerGameOver() {
        finished = true
        
        playerNode.playExplosion(playerNode.position)
        
        playerNode.removeFromParent()
        
        let transition = SKTransition.doorsOpenVertical(withDuration: 1)
        let gameover = GameOverScene(size: frame.size)
        view?.presentScene(gameover, transition: transition)
        
        self.run(SKAction.playSoundFileNamed("gameOver.wav", waitForCompletion: false))
    }
}
