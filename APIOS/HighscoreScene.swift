//
//  HighscoreScene.swift
//  APIOS
//
//  Created by Kacper on 13.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import SpriteKit

class HighscoreScene: SKScene {
    
    private var scoreLebel: SKLabelNode?;
    
    
    override func didMove(to view: SKView) {
        getReference();
        setScore();
    }
    
    private func getReference() {
        scoreLebel = self.childNode(withName: "Score Label") as? SKLabelNode!;
    }
    
    private func setScore() {
        if GameManager.instance.getEasyDifficulty() {
            scoreLebel?.text = String(GameManager.instance.getEasyDifficultyScore());
        } else if GameManager.instance.getMediumDifficulty() {
            scoreLebel?.text = String(GameManager.instance.getMediumDifficultyScore());
        } else if GameManager.instance.getHardDifficulty() {
            scoreLebel?.text = String(GameManager.instance.getHardDifficultyScore());
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                
                scene!.scaleMode = .aspectFit;
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));

            }
        }
    }
    
    
}
