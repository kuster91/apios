//
//  GameplayScene.swift
//  APIOS
//
//  Created by Kacper on 14.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameplayScene: SKScene ,SKPhysicsContactDelegate{
    
    private var pausePanel: SKSpriteNode?;
    
    let manager = CMMotionManager();
    //var playerInfo = Player();
    var player = SKSpriteNode();
    var finalItem = SKSpriteNode();
    
    var trapItem = SKSpriteNode();
    
    private var label : SKLabelNode?;
    private var spinnyNode : SKShapeNode?;
    
    func initializeGame(){
        getLebels();
    
        self.physicsWorld.contactDelegate = self;
        
        player = self.childNode(withName: "Player") as! SKSpriteNode;
        finalItem = self.childNode(withName: "FinalItem") as! SKSpriteNode;
        
        getLebels();
        GameplayController.instance.initializeVeriables();

        //collect gravity to move player object
        manager.startAccelerometerUpdates();
        manager.accelerometerUpdateInterval = 0.1;
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * GameplayController.instance.ratio! , dy: CGFloat((data?.acceleration.y)!) * GameplayController.instance.ratio! );
        }
        
    }
    
    override func didMove(to view: SKView) {
        
        initializeGame();
        //add traps to scene
        var traps:[SKSpriteNode] = [];
        var i = 0;
        while i < (GameplayController.instance.level! * 2) {
            traps.append(SKSpriteNode(imageNamed: "trap"));
            traps[i] = SKSpriteNode(imageNamed: "trap");
            traps[i].name = "Trap";
            traps[i].position = CGPoint(x: randomBetweenNumbers(firstNum: CGFloat(-180), secondNum: CGFloat(180)), y: randomBetweenNumbers(firstNum: CGFloat(-330), secondNum: CGFloat(330)) );
            traps[i].zPosition = 2;
            traps[i].physicsBody?.isDynamic = false;
            traps[i].physicsBody?.pinned = false;
            traps[i].physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(20));
            traps[i].physicsBody?.affectedByGravity = false;
            self.addChild(traps[i]);
            
            traps.append(SKSpriteNode(imageNamed: "trap"));
            traps[i+1] = SKSpriteNode(imageNamed: "trap");
            traps[i+1].name = "Trap";
            traps[i+1].position = CGPoint(x: randomBetweenNumbers(firstNum: CGFloat(-180), secondNum: CGFloat(-30)), y: randomBetweenNumbers(firstNum: CGFloat(-330), secondNum: CGFloat(330)) );
            traps[i+1].zPosition = 2;
            traps[i+1].physicsBody?.isDynamic = false;
            traps[i+1].physicsBody?.pinned = false;
            traps[i+1].physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(20));
            traps[i+1].physicsBody?.affectedByGravity = false;
            self.addChild(traps[i+1]);
            
            i += 2;
    }
         // random generate extra life on scene -- the same pic as coin
        if Int(arc4random_uniform(4)) == 2 {
            let extraLife = SKSpriteNode(imageNamed: "Coin");
            extraLife.name = "Life";
            extraLife.position = CGPoint(x: randomBetweenNumbers(firstNum: CGFloat(-180), secondNum: CGFloat(180)), y: randomBetweenNumbers(firstNum: CGFloat(-330), secondNum: CGFloat(330)) );
            extraLife.zPosition = 2;
            extraLife.physicsBody?.isDynamic = false;
            extraLife.physicsBody?.pinned = true;
            extraLife.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(20));
            extraLife.physicsBody?.affectedByGravity = false;
            self.addChild(extraLife);
            
        }
        // random generate coin object on scene
        if Int(arc4random_uniform(4)) == 3 {
            let coin = SKSpriteNode(imageNamed: "Coin");
            coin.name = "Coin";
            coin.position = CGPoint(x: randomBetweenNumbers(firstNum: CGFloat(-180), secondNum: CGFloat(180)), y: randomBetweenNumbers(firstNum: CGFloat(-330), secondNum: CGFloat(330)) );
            coin.zPosition = 2;
            coin.physicsBody?.isDynamic = false;
            coin.physicsBody?.pinned = true;
            coin.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(20));
            coin.physicsBody?.affectedByGravity = false;
            self.addChild(coin);
        }
        GameplayController.instance.levelText?.text = "\(GameplayController.instance.level!)"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self);
        
            if atPoint(location).name == "Pause" {
                
                self.scene?.isPaused = true;
                createPausePanel();
                manager.stopAccelerometerUpdates();
            }
            
            if atPoint(location).name == "Resume" {
                pausePanel?.removeFromParent();
                self.scene?.isPaused = false;
                
                manager.startAccelerometerUpdates();
                manager.accelerometerUpdateInterval = 0.1;
                manager.startAccelerometerUpdates(to: OperationQueue.main){
                    (data, error) in
                    
                    self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * GameplayController.instance.ratio! , dy: CGFloat((data?.acceleration.y)!) * GameplayController.instance.ratio! );
                    print("gravitacja: ")
                    print(self.physicsWorld.gravity);
                }

            }
            
            if atPoint(location).name == "Quit" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                scene!.scaleMode = .aspectFit;
                
                manager.stopAccelerometerUpdates();
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
            }
            if atPoint(location).name == "Back" {
                let scene = MainMenuScene(fileNamed: "MainMenu");
                
                manager.stopAccelerometerUpdates();
                scene!.scaleMode = .aspectFit;
                
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 1));
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                
            }

        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {

        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
        } else {
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Life" {
            self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false));
            GameplayController.instance.incrementLife();
            secondBody.node?.removeFromParent();
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false));
            GameplayController.instance.incrementCoin();
            secondBody.node?.removeFromParent();
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Trap" {
            
            manager.stopAccelerometerUpdates();
            self.scene?.isPaused = true;
            
            GameplayController.instance.life! -= 1;
            
            if GameplayController.instance.life! >= 0 {
                GameplayController.instance.lifeText?.text = "x\(GameplayController.instance.life!)"
            } else {
                createEndScorePanel();
            }
            
            firstBody.node?.removeFromParent();
            
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false);
            
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "FinalItem" {
            
            manager.stopAccelerometerUpdates();
            if GameplayController.instance.level! >= 5{
                GameplayController.instance.incrementScore();
                GameplayController.instance.incrementScore();
                GameplayController.instance.incrementScore();
                GameplayController.instance.life = -1;
                firstBody.node?.removeFromParent();
                createEndScorePanel()
                
               Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(GameplayScene.playerDied), userInfo: nil, repeats: false);
            }else{
                GameplayController.instance.incrementLevel();
                GameplayController.instance.incrementScore();
                let scene = GameplayScene(fileNamed: "GameplayScene");
                scene!.scaleMode = .aspectFit;
                self.view?.presentScene(scene!, transition: SKTransition.doorway(withDuration: 1))
            }
        }

    }
    
    func getLebels(){
        GameplayController.instance.scoreText = self.childNode(withName: "Score Text") as! SKLabelNode?;
        GameplayController.instance.lifeText = self.childNode(withName: "Life Text") as! SKLabelNode?;
        GameplayController.instance.levelText = self.childNode(withName: "Level Text") as! SKLabelNode?;
    }
    
    func createPausePanel(){
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu");
        let resumeBtn = SKSpriteNode(imageNamed: "Resume Button");
        let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2");
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        pausePanel?.xScale = 1.6;
        pausePanel?.yScale = 1.6;
        pausePanel?.zPosition = 4;
        pausePanel?.position = CGPoint (x: 0, y: 0);
        
        resumeBtn.name = "Resume";
        resumeBtn.zPosition = 5;
        resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        resumeBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)!+25);
        
        quitBtn.name = "Quit";
        quitBtn.zPosition = 5;
        quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        quitBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)!-45);
        
        pausePanel?.addChild(resumeBtn);
        pausePanel?.addChild(quitBtn);
        
        
        self.addChild(pausePanel!);
        
    }
    
    private func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score");
        let scoreLabel = SKLabelNode(fontNamed: "Blow");
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        endScorePanel.zPosition = 8;
        endScorePanel.xScale = 1.5;
        endScorePanel.yScale = 1.5;
        
        scoreLabel.text = "\(GameplayController.instance.score!)"
        
        endScorePanel.addChild(scoreLabel);
        
        scoreLabel.fontSize = 50;
        scoreLabel.zPosition = 7;
        
        endScorePanel.position = CGPoint(x: 0, y: 0);
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + 10);

        self.addChild(endScorePanel);
        
    }
    
    private func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
    }
    
    @objc
    private func playerDied() {
        if GameplayController.instance.life! >= 0 {
            GameManager.instance.gameRestartedPlayerDied = true;
            
            let scene = GameplayScene(fileNamed: "GameplayScene");
            scene?.scaleMode = SKSceneScaleMode.aspectFit;
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
        } else {
            if GameManager.instance.getEasyDifficulty() {
                let highscore = GameManager.instance.getEasyDifficultyScore();
                
                if highscore < Int32(GameplayController.instance.score!) {
                    GameManager.instance.setEasyDifficultyScore(Int32(GameplayController.instance.score!));
                }
            } else if GameManager.instance.getMediumDifficulty() {
                let highscore = GameManager.instance.getMediumDifficultyScore();
                
                if highscore < Int32(GameplayController.instance.score!) {
                    GameManager.instance.setMediumDifficultyScore(Int32(GameplayController.instance.score!));
                }
            } else if GameManager.instance.getHardDifficulty() {
                let highscore = GameManager.instance.getHardDifficultyScore();
                
                if highscore < Int32(GameplayController.instance.score!) {
                    GameManager.instance.setHardDifficultyScore(Int32(GameplayController.instance.score!));
                }
                
            }
            
            GameManager.instance.saveData();
            
            let scene = MainMenuScene(fileNamed: "MainMenu");
            scene?.scaleMode = SKSceneScaleMode.aspectFit;
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 1));
        }
        
    }
}
