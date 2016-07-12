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
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

   
    
    
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        for touch in touches {
//            let location = touch.locationInView(self.view)
//            
//            let screenSize : CGRect = UIScreen.mainScreen().bounds
//            
//            let smallX = screenSize.width * 0.34
//            let smallY = screenSize.height * 0.8
//            
//            let centerPadX = screenSize.width * 0.17
//            let centerPadY = screenSize.height * 0.9
//            
//            //print("C : \(smallX) \(smallY) \(centerPadX) \(centerPadY) \(location.x) \(location.y)")
//            
//            //print("Controller : \(centerPadX) - \(location.x)")
//            if location.x <= smallX && location.y >= smallY{
//                
//                //let vector = CGVectorMake(-(centerPadX - location.x), -(centerPadY-location.y))
//                              
//            }
//            
//            
//            
//        }
//        
//    }

    
    
}
