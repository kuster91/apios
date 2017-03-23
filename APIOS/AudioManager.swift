//
//  AudioManager.swift
//  APIOS
//
//  Created by Kacper on 15.01.2017.
//  Copyright © 2017 Kuster Software Development. All rights reserved.
//

import AVFoundation

// class is managing sounds in game
class AudioManager {
    //implement as design pattern singleton
    static let instance = AudioManager();
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?;
    
    func playBGMusic() {
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3");
        
        var err: NSError?;
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!);
            audioPlayer?.numberOfLoops = -1;
            audioPlayer?.prepareToPlay();
            audioPlayer?.play();
        } catch let err1 as NSError {
            err = err1;
        }
        
        if err != nil {
            print(err!);
        }
    }
    
    func stopBGMusic() {
        if (audioPlayer?.isPlaying) != nil {
            audioPlayer?.stop();
        }
    }
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil;
    }
    
}
