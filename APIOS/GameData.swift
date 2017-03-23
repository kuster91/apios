//
//  GameData.swift
//  APIOS
//
//  Created by Kacper on 14.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import Foundation

//class responsible for get and set game data - game level highscores and music option
class GameData: NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficultyScore = "EasyDifficultyScore";
        static let MediumDifficultyScore = "MediumDifficultyScore";
        static let HardDifficultyScore = "HardDifficultyScore";
        
        
        static let EasyDifficulty = "EasyDifficulty";
        static let MediumDifficulty = "MediumDifficulty";
        static let HardDifficulty = "HardDifficulty";
        
        static let Music = "Music";
    }
    
    fileprivate var easyDifficultyScore = Int32();
    fileprivate var mediumDifficultyScore = Int32();
    fileprivate var hardDifficultyScore = Int32();
    

    fileprivate var easyDifficulty = false;
    fileprivate var mediumDifficulty = false;
    fileprivate var hardDifficulty = false;
    
    fileprivate var isMusicOn = false;
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        //        super.init();
        
        self.easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyScore);
        self.mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyScore);
        self.hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyScore);
        
        self.easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficulty);
        self.mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficulty);
        self.hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficulty);
        
        self.isMusicOn = aDecoder.decodeBool(forKey: Keys.Music);
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encodeCInt(self.easyDifficultyScore, forKey: Keys.EasyDifficultyScore);
        
        aCoder.encodeCInt(self.mediumDifficultyScore, forKey: Keys.MediumDifficultyScore);
        
        aCoder.encodeCInt(self.hardDifficultyScore, forKey: Keys.HardDifficultyScore);
        
        aCoder.encode(self.easyDifficulty, forKey: Keys.EasyDifficulty);
        aCoder.encode(self.mediumDifficulty, forKey: Keys.MediumDifficulty);
        aCoder.encode(self.hardDifficulty, forKey: Keys.HardDifficulty);
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music);
        
    }
    
    
    //getters and setters
    func setEasyDifficultyScore(_ easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore;
    }
    

    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore;
    }

    func setMediumDifficultyScore(_ mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore;
    }
    

    
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore;
    }
    

    
    func setHardDifficultyScore(_ hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore;
    }
    

    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore;
    }
    

    
    func setEasyDifficulty(_ easyDifficulty: Bool) {
        self.easyDifficulty = easyDifficulty;
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty;
    }
    
    func setMediumDifficulty(_ mediumDifficulty: Bool) {
        self.mediumDifficulty = mediumDifficulty;
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty;
    }
    
    func setHardDifficulty(_ hardDifficulty: Bool) {
        self.hardDifficulty = hardDifficulty;
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty;
    }
    
    func setIsMusicOn(_ isMusicOn: Bool) {
        self.isMusicOn = isMusicOn;
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn;
    }
    
}
