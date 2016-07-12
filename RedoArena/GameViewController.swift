//
//  GameViewController.swift
//  RedoArena
//
//  Created by iD Student on 7/11/16.
//  Copyright (c) 2016 iD Student. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            //scene.scaleMode = .AspectFill
            scene.size = skView.bounds.size
           
            
            
            //scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0, 0, skView.frame.width, skView.frame.height * 0.25))
           // scene.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: self.frame];
    

        

            skView.presentScene(scene)
        }
        
        self.view.sendSubviewToBack(bottomView)
    }

   
    
    


    
    
}
