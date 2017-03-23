//
//  OptionScene.swift
//  APIOS
//
//  Created by Kacper on 13.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import SpriteKit

class OptionScene: SKScene {
    
    private var easyBtn: SKSpriteNode?;
    private var mediumBtn: SKSpriteNode?;
    private var hardBtn: SKSpriteNode?;
    private var sign: SKSpriteNode?;
    
    override func didMove(to view: SKView) {
        initializeVeriables();
        setSign();
    }
    
    func initializeVeriables(){
        easyBtn = self.childNode(withName: "Easy Button") as? SKSpriteNode!;
        mediumBtn = self.childNode(withName: "Medium Button") as? SKSpriteNode!;
        hardBtn = self.childNode(withName: "Hard Button") as? SKSpriteNode!;
        sign = self.childNode(withName: "Sign") as? SKSpriteNode!;
    }
    
    func setSign() {
        if GameManager.instance.getEasyDifficulty() == true {
            sign?.position.y = (easyBtn?.position.y)!;
        } else if GameManager.instance.getMediumDifficulty() == true {
            sign?.position.y = (mediumBtn?.position.y)!;
        } else if GameManager.instance.getHardDifficulty() == true {
            sign?.position.y = (hardBtn?.position.y)!;
        }
    }
    
    
    fileprivate func setDifficulty(_ difficulty: String) {
        switch(difficulty) {
        case "easy":
            GameManager.instance.setEasyDifficulty(true);
            GameManager.instance.setMediumDifficulty(false);
            GameManager.instance.setHardDifficulty(false);
            break;
            
        case "medium":
            GameManager.instance.setEasyDifficulty(false);
            GameManager.instance.setMediumDifficulty(true);
            GameManager.instance.setHardDifficulty(false);
            break;
            
        case "hard":
            GameManager.instance.setEasyDifficulty(false);
            GameManager.instance.setMediumDifficulty(false);
            GameManager.instance.setHardDifficulty(true);
            break;
            
        default:
            break;
        }
        GameManager.instance.saveData();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self);
     
            
            if atPoint(location).name  == "Easy Button" {
                sign!.position.y = easyBtn!.position.y;
                setDifficulty("easy");
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));

            }
            
            if atPoint(location).name == "Medium Button" {
                sign!.position.y = mediumBtn!.position.y;
                setDifficulty("medium");
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                
            }
            
            if atPoint(location).name  == "Hard Button" {
                sign!.position.y = hardBtn!.position.y;
                setDifficulty("hard");
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));

            }
            
            sign?.zPosition = 4;
            
            
            if atPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                
                scene!.scaleMode = .aspectFit;
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));

            }
        }
    }

    
}
