//
//  GameManager.swift
//  APIOS
//
//  Created by Kacper on 14.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import Foundation

// design pattern - singleton
// class for manage game

class GameManager {
    
    static let instance = GameManager();
    private init(){}
    
    private var gameData: GameData?;
    
    var gameStartedFromMainMenu = false;
    var gameRestartedPlayerDied = false;
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32){
        gameData?.setEasyDifficultyScore(easyDifficultyScore);
    }
    
    
    func initializeGameData() {
        
        if !FileManager.default.fileExists(atPath: getFilePath() as String) {
            // setup our game with initial values
            gameData = GameData();
            
            gameData?.setEasyDifficultyScore(0);
            gameData?.setMediumDifficultyScore(0);
            gameData?.setHardDifficultyScore(0);
            
            gameData?.setEasyDifficulty(false);
            gameData?.setMediumDifficulty(true);
            gameData?.setHardDifficulty(false);
            
            gameData?.setIsMusicOn(false);
            
            saveData();
        }
        
        loadData();
        
    }
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData!
    }
    
    func saveData() {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String);
        }
    }
    
    fileprivate func getFilePath() -> String {
        let manager = FileManager.default;
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!;
        return url!.appendingPathComponent("Game Data").path;
    }
    
    func setEasyDifficultyScore(_ easyDifficultyScore: Int32) {
        gameData!.setEasyDifficultyScore(easyDifficultyScore);
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return gameData!.getEasyDifficultyScore();
    }
    
    func setMediumDifficultyScore(_ mediumDifficultyScore: Int32) {
        gameData!.setMediumDifficultyScore(mediumDifficultyScore);
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return gameData!.getMediumDifficultyScore();
    }
    
    func setHardDifficultyScore(_ hardDifficultyScore: Int32) {
        gameData!.setHardDifficultyScore(hardDifficultyScore);
    }
    
    func getHardDifficultyScore() -> Int32 {
        return gameData!.getHardDifficultyScore();
    }
    
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        gameData!.setEasyDifficulty(easyDifficulty);
    }
    
    func getEasyDifficulty() -> Bool {
        return gameData!.getEasyDifficulty();
    }
    
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        gameData!.setMediumDifficulty(mediumDifficulty);
    }
    
    func getMediumDifficulty() -> Bool {
        return gameData!.getMediumDifficulty();
    }
    
    func setHardDifficulty(_ hardDifficulty: Bool) {
        gameData!.setHardDifficulty(hardDifficulty);
    }
    
    func getHardDifficulty() -> Bool {
        return gameData!.getHardDifficulty();
    }
    
    func setIsMusicOn(_ isMusicOn: Bool) {
        gameData!.setIsMusicOn(isMusicOn);
    }
    
    func getIsMusicOn() -> Bool {
        return gameData!.getIsMusicOn();
    }
    
}
