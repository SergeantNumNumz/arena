//
//  GameScene.swift
//  RedoArena
//
//  Created by iD Student on 7/11/16.
//  Copyright (c) 2016 iD Student. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    let player = SKSpriteNode()
    let marker = SKSpriteNode()
    let screenHeight = UIScreen.mainScreen().bounds.height
    let screenWidth = UIScreen.mainScreen().bounds.width

    var shape = SKShapeNode()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        // move to init method
        
        print("\(screenHeight), \(screenWidth)")
        
        
        print("\(self.size.width), \(self.size.height)")
        
        shape = SKShapeNode(rect: CGRectMake(self.size.width * 0.2, 0, screenWidth * 0.4, screenHeight * 0.25))
        shape.fillColor = UIColor.redColor()

        
     
//        shape.path = UIBezierPath(roundedRect: CGRect(x: 0, y: screenHeight * 0.75, width: screenWidth * 0.4, height: screenHeight * 0.25), cornerRadius: 64).CGPath
//        shape.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
//        shape.fillColor = UIColor.redColor()
//        shape.strokeColor = UIColor.blueColor()
//        shape.lineWidth = 10
        
        
        addChild(shape)
        
        
        //backgroundColor = SKColor.whiteColor()
        
        player.size = CGSize(width: 40.0, height: 40.0)
        player.color = UIColor.greenColor()
        player.position = CGPointMake(400, 400)
        
        
        addChild(player)
        
        
        let screenSize : CGRect = UIScreen.mainScreen().bounds
        
        
        let centerPadX = screenSize.width * 0.17
        let centerPadY = screenSize.height * 0.9
        
        marker.size = CGSize(width: 10.0, height: 10.0)
        marker.color = UIColor.blackColor()
        marker.position = CGPointMake(centerPadX, centerPadY)
        
        addChild(marker)
        
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        
        for touch in touches {
            let location = touch.locationInView(self.view)
            
            print("Touch : \(location.x), \(location.y)")
        
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        for touch in touches {
            let location = touch.locationInView(self.view)
            let screenSize : CGRect = UIScreen.mainScreen().bounds
            
            let smallX = screenSize.width * 0.34
            let smallY = screenSize.height * 0.8
            
            let centerPadX = screenSize.width * 0.17
            let centerPadY = screenSize.height * 0.9
            
            let v = CGVector(dx: location.x - centerPadX, dy: -(location.y - centerPadY))
            
            if location.x <= smallX && location.y >= smallY{
                //
            let projectileAction = SKAction.sequence([
                SKAction.repeatAction(
                    SKAction.moveBy(v, duration: 0.5), count: 1),
                SKAction.waitForDuration(0.5),
                SKAction.removeFromParent()
                ])
            
            
            
            player.runAction(projectileAction)
                
            }
//            let angle = atan2(v.dx, v.dy)
//            
//            let deg = angle * CGFloat(180 / M_PI)
//            
//            print(deg + 180)
            
            
        }
    }
    
}

