//
//  GameplayController.swift
//  APIOS
//
//  Created by Kacper on 14.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import SpriteKit
import Foundation

//class responsible for controll game data implement as design patterns singleton
class GameplayController {
    
    static let instance = GameplayController();
    private init(){}
    
    var score: Int?;
    var life: Int?;
    var ratio: CGFloat?;
    var level: Int?;
    
    var scoreText: SKLabelNode?;
    var lifeText: SKLabelNode?;
    var levelText: SKLabelNode?;
    
    
    // set up starting params
    func initializeVeriables(){
        
        if GameManager.instance.gameStartedFromMainMenu{
            
            GameManager.instance.gameStartedFromMainMenu = false;
            score = 0;
            
            if GameManager.instance.getEasyDifficulty(){
                life = 5;
                ratio = 1;
            }else if GameManager.instance.getMediumDifficulty(){
                life  = 3;
                ratio = 10;
            }else if GameManager.instance.getHardDifficulty(){
                life = 1;
                ratio = 50;
            }
            level = 1;
            
            scoreText?.text = "\(score!)";
            lifeText?.text = "x\(life!)";
        }else{
            GameManager.instance.gameRestartedPlayerDied = false;
            
            scoreText?.text = "\(score!)";
            lifeText?.text = "x\(life!)";
        }
    }
    
    func incrementScore() {
        score! += 1000;
        scoreText?.text = "\(score!)";
    }
    
    func levelUp() {
        level! += 1;
    }
    
    func incrementCoin() {
        score! += 200;
        scoreText?.text = "\(score!)";
    }
    
    func incrementLevel (){
        level! += 1;
        levelText?.text = "\(level!)";
    }
    
    func incrementLife() {
        life! += 1;
        score! += 300;
        
        lifeText?.text = "x\(life!)";
        scoreText?.text = "\(score!)";
    }
}
