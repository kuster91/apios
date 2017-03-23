//
//  MainMenuScene.swift
//  APIOS
//
//  Created by Kacper on 13.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import SpriteKit
import Darwin


class MainMenuScene: SKScene {
    
    
    private var musicBtn: SKSpriteNode?;
    private let musicOn = SKTexture(imageNamed: "Music On Button");
    private let musicOff = SKTexture(imageNamed: "Music Off Button");
    
    
    override func didMove(to view: SKView) {
        GameManager.instance.initializeGameData();
        setMusic();
        musicBtn = self.childNode(withName: "Music") as! SKSpriteNode!;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self);
            
            if atPoint(location).name == "Highscore" {
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                
                scene!.scaleMode = .aspectFit;
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1) );
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));

            }
            
            if atPoint(location).name == "Option" {
                let scene = OptionScene(fileNamed: "OptionScene")
                
                scene!.scaleMode = .aspectFit;
                
                self.view?.presentScene(scene!, transition: SKTransition.doorway(withDuration: 1))
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
            }
            
            if atPoint(location).name == "Start Game" {
                GameManager.instance.gameStartedFromMainMenu = true;
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene!.scaleMode = .aspectFit;
                
                self.view?.presentScene(scene!, transition: SKTransition.doorway(withDuration: 1))
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
            }
            
            if atPoint(location).name == "Music" {
                handleMusicButton();
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
            }
            
            if atPoint(location).name == "Quit"{
                //UIControl.sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil);
                exit(0);
            }
        }
    }
    
    private func setMusic() {
        if GameManager.instance.getIsMusicOn() {
            if AudioManager.instance.isAudioPlayerInitialized() {
                AudioManager.instance.playBGMusic();
                musicBtn?.texture = musicOff;
            }
        }
    }
    
    private func handleMusicButton() {
        if GameManager.instance.getIsMusicOn() {
            AudioManager.instance.stopBGMusic();
            GameManager.instance.setIsMusicOn(false);
            musicBtn?.texture = musicOn;
        } else {
            AudioManager.instance.playBGMusic();
            GameManager.instance.setIsMusicOn(true);
            musicBtn?.texture = musicOff;
        }
        GameManager.instance.saveData();
    }
    
}
