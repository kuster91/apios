//
//  CollectablesController.swift
//  APIOS
//
//  Created by Kacper on 14.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import SpriteKit

class CollectablesController{
    
    func getCollectable () -> SKSpriteNode{
        
        var collectable = SKSpriteNode();
        
        if Int(randomBetweenNumbers(firstNum: 0, secNum: 7)) >= 4 {
            
            
            if GameplayController.instance.life! < 1{
                collectable = SKSpriteNode (imageNamed: "Life");
                collectable.name = "Life";
                collectable.physicsBody = SKPhysicsBody(rectangleOf: collectable.size);
            }
        } else{
            collectable = SKSpriteNode(imageNamed: "Coin")
            collectable.name = "Coin";
            collectable.physicsBody = SKPhysicsBody(circleOfRadius: collectable.size.height / 2);
        }
        
        
        collectable.physicsBody?.affectedByGravity = false;
        
        return collectable;
    }
    
    func randomBetweenNumbers(firstNum: CGFloat, secNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secNum) + min(firstNum, secNum);
    }
    
}
