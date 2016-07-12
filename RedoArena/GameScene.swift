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
    
    var touchPadX : CGFloat = 0.0
    var touchPadY : CGFloat = 0.0

    var shape = SKShapeNode()
    
   // var v = CGVector(dx: 0.0, dy: 0.0)
    var v : CGVector = CGVectorMake(0.0, 0.0)
   
   // var v = CGVectorMake(0.0, 0.0)
    
    
 
    
    
    

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
       
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsBody = physicsBody
      
        
        print("\(screenHeight), \(screenWidth)")
        print("\(self.size.width), \(self.size.height)")
        
        
        shape = SKShapeNode(rect: CGRectMake(0, 0, screenWidth * 0.4, screenHeight * 0.25))
        shape.fillColor = UIColor.redColor()
        addChild(shape)
        
       
        //backgroundColor = SKColor.whiteColor()
        
        player.size = CGSize(width: 40.0, height: 40.0)
        player.color = UIColor.greenColor()
        
        
        player.position = CGPointMake(screenWidth * 0.25, screenHeight * 0.25)
        player.physicsBody = SKPhysicsBody(circleOfRadius: 5)
     
        addChild(player)
        
        
        touchPadY = shape.frame.size.height
        touchPadX = shape.frame.size.width
        
    
        marker.size = CGSize(width: 10.0, height: 10.0)
        marker.color = UIColor.blackColor()
        marker.position = CGPointMake(touchPadX * 0.5, touchPadY * 0.5)
        
        addChild(marker)
        
   
    }
    
    
    override func update(currentTime: CFTimeInterval) {
       
        player.physicsBody?.applyImpulse(v)
       v = CGVectorMake(0.0, 0.0)
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPadY = shape.frame.size.height
        touchPadX = shape.frame.size.width
        
        
        for touch in touches {
            var location = touch.locationInView(self.view)
            
            //print("Touch : \(location.x), \(location.y)")
            
            location.y = screenHeight - location.y
            
            
             v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)
         
            //print("Touch : \(Int(location.x)), \(Int(location.y)) Vector : \(Int(location.x - touchPadX * 0.5)), \(Int(location.y - touchPadY * 0.5))")
            
            //print("\(location.y) <= \(touchPadY)")
            
//            if location.x <= touchPadX && location.y <= touchPadY{
//                
//                
//                let projectileAction = SKAction.sequence([
//                    SKAction.repeatAction(
//                        SKAction.moveBy(v, duration: 0.5), count: 1),
//                    SKAction.waitForDuration(0.5),
//                    SKAction.removeFromParent()
//                    ])
//
//                
//                
//                player.runAction(projectileAction)
//   // print("Inside")
//                print(player.position)
            
//                let action = SKAction.sequence(
//                [player.physicsBody applyImpulse:CGVectorMake(dx,dy)]
                
//            }
//            
//            else{
//                
//                player.position = CGPointMake(screenWidth * 0.25, screenHeight * 0.25)
//                player.hidden = false
//                print(player.position)
//                print("moved player back")
//                
//            }

        
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPadY = shape.frame.size.height
        touchPadX = shape.frame.size.width
        
        for touch in touches {
            var location = touch.locationInView(self.view)
            
          location.y = screenHeight - location.y
            
            
            
             v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)
            
//            if location.x <= touchPadX && location.y >= touchPadY{
//                
//       
//                
//                
//            let projectileAction = SKAction.sequence([
//                SKAction.repeatAction(
//                    SKAction.moveBy(v, duration: 0.5), count: 1),
//                SKAction.waitForDuration(0.5),
//                SKAction.removeFromParent()
//                ])
//            
//            
//            
//            player.runAction(projectileAction)
//                
//            }

            
            
        }
    }
    
}

