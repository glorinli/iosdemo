//
//  GameViewController.swift
//  TextShooter
//
//  Created by Glorin Li on 2020/4/30.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
//            let scene = GameScene(size: view.frame.size, levelNumber: 1)
            let scene = StartScene(size: view.frame.size)
            scene.scaleMode = .aspectFill
            
            view.presentScene(scene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
