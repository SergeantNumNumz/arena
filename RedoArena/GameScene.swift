//
//  GameScene.swift
//  RedoArena
//
//  Created by iD Student on 7/11/16.
//  Copyright (c) 2016 iD Student. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // Button should move sprite forward in a burst (lunge), but because on touchend velocity set to 0,it doesnt move at all
    
let player = SKSpriteNode()
    let marker = SKSpriteNode()
    let screenHeight = UIScreen.mainScreen().bounds.height
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    var touchPadX : CGFloat = 0.0
    var touchPadY : CGFloat = 0.0

    var shape = SKShapeNode()
    var shapea = SKShapeNode()
   // var v = CGVector(dx: 0.0, dy: 0.0)
    var v : CGVector = CGVectorMake(0.0, 0.0)
   
   // var v = CGVectorMake(0.0, 0.0)
    
    var attackButton = SKShapeNode()
 
    var playerSpeed : CGFloat = 0.0
    var playerAngle : CGFloat = 0.0
    

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    
        shapea = SKShapeNode(rect: CGRectMake(0, 0, screenWidth, screenHeight * 0.28))
        shapea.fillColor = UIColor.whiteColor()
        
        shapea.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(0.0, 0.0, screenWidth, screenHeight * 0.28))
        shapea.physicsBody?.dynamic = false
        
        addChild(shapea)
        
        
        
        attackButton = SKShapeNode(rect: CGRectMake(screenWidth * 0.5, screenHeight * 0.05, screenWidth * 0.1, screenHeight * 0.05))
        attackButton.fillColor = UIColor.grayColor()
        
        addChild(attackButton)
        
      
        
        let physicsBody = SKPhysicsBody (edgeLoopFromRect: self.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsBody = physicsBody
      
        
        print("\(screenHeight), \(screenWidth)")
        print("\(self.size.width), \(self.size.height)")
        
        
        shape = SKShapeNode(rect: CGRectMake(0, 0, screenWidth * 0.4, screenHeight * 0.25))
        shape.fillColor = UIColor.grayColor()
  
        
        addChild(shape)
       
        
        
        //backgroundColor = SKColor.whiteColor()
        
        player.size = CGSize(width: 40.0, height: 40.0)
        player.color = UIColor.greenColor()
        
        
        player.position = CGPointMake(screenWidth * 0.5, screenHeight * 0.75)
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
        
        playerSpeed = sqrt((player.physicsBody?.velocity.dx)!*(player.physicsBody?.velocity.dx)! + (player.physicsBody?.velocity.dy)!*(player.physicsBody?.velocity.dy)!)
        playerAngle = atan2((player.physicsBody?.velocity.dy)!, (player.physicsBody?.velocity.dx)!)
        
        
        if (playerSpeed > 0.01) {
            player.zRotation = playerAngle
        }
        
        else {
            
            player.physicsBody?.angularVelocity = (0.0)
        }
        
       player.physicsBody?.velocity = (CGVectorMake(0.0, 0.0))
      
        player.physicsBody?.applyImpulse(v)
        
        
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {

        
//     v = CGVectorMake(0.0, 0.0)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPadY = shape.frame.size.height
        touchPadX = shape.frame.size.width
        
        
        for touch in touches {
            var location = touch.locationInView(self.view)
            
            //print("Touch : \(location.x), \(location.y)")
            
            location.y = screenHeight - location.y
            
           
            if location.x <= touchPadX && location.y <= touchPadY{
      
                
                v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)
                let magnitude = sqrt(v.dx * v.dx + v.dy * v.dy)
                
                v = CGVectorMake(v.dx/magnitude, v.dy/magnitude)
                
                
                
            }
            
            
                
            else if CGRectContainsPoint(attackButton.frame, location){
                
                print("attack : \(CGVectorMake(v.dx * 100, v.dy * 100))")
                
               
                player.physicsBody?.applyImpulse(CGVectorMake(v.dx * 100, v.dy * 100))
            }

        
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPadY = shape.frame.size.height
        touchPadX = shape.frame.size.width
        
        for touch in touches {
            var location = touch.locationInView(self.view)
            
          location.y = screenHeight - location.y
            
            if location.x <= touchPadX && location.y <= touchPadY{
            
             v = CGVector(dx: location.x - touchPadX * 0.5, dy: location.y - touchPadY * 0.5)
            let magnitude = sqrt(v.dx * v.dx + v.dy * v.dy)
            
            v = CGVectorMake(v.dx/magnitude, v.dy/magnitude)
            
            
            
            
            if (playerSpeed > 0.01) {
                player.zRotation = playerAngle
            }
                
            else {
                
                player.physicsBody?.angularVelocity = (0.0)
            }
            
            }
            
          
            
            
        }
    }
    
}

