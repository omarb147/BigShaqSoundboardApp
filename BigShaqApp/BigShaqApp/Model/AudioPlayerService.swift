//
//  SoundPlayer.swift
//  BigShaqApp
//
//  Created by Omar Bello on 13/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import Foundation
import AVFoundation


class AudioPlayerService {
    
    static var  instance = AudioPlayerService()
    
    var audioEngine:AVAudioEngine?
    var reverbPlayer:AVAudioPlayerNode!
    var echoPlayer : AVAudioPlayerNode!
    var pitchPlayer:AVAudioPlayerNode!

    
    func playsound(soundName:String){
        
            
        audioEngine = AVAudioEngine()
        reverbPlayer = AVAudioPlayerNode()
        echoPlayer = AVAudioPlayerNode()
        pitchPlayer = AVAudioPlayerNode()
        
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {return}
        let file = try? AVAudioFile(forReading: url)
        let buffer = AVAudioPCMBuffer(pcmFormat: file!.processingFormat, frameCapacity: AVAudioFrameCount(file!.length))
        try! file!.read(into: buffer!)
        

        let reverb = AVAudioUnitReverb()
        let echo = AVAudioUnitDelay()
        let pitch = AVAudioUnitTimePitch()
        let distortion = AVAudioUnitDistortion()
        
        audioEngine?.attach(reverbPlayer)
       
        audioEngine?.attach(echoPlayer)
        
        echo.delayTime = 0
        //reverb.wetDryMix = 100
        
        audioEngine?.attach(pitchPlayer)
        audioEngine?.attach(reverb)
        audioEngine?.attach(echo)
        audioEngine?.attach(pitch)
        audioEngine?.attach(distortion)
        distortion.loadFactoryPreset(.speechGoldenPi)
        pitch.rate = 1
        
    
            
        audioEngine?.connect(reverbPlayer, to: reverb, format:buffer?.format)
        audioEngine?.connect(reverb, to: echo, format: buffer?.format)
        audioEngine?.connect(echo, to: pitch, format: buffer?.format)
        audioEngine?.connect(pitch, to: distortion, format: buffer?.format)
        audioEngine?.connect(distortion, to: (audioEngine?.mainMixerNode)!, format:buffer?.format)
        
        //audioEngine?.connect(echoPlayer, to: echo, format:buffer?.format)
        //audioEngine?.connect(echo, to: (audioEngine?.mainMixerNode)!, format:buffer?.format)
        //audioEngine?.connect(pitchPlayer, to: pitch, format: buffer?.format)
        //audioEngine?.connect(pitch, to: (audioEngine?.mainMixerNode)!, format:buffer?.format)
        
        reverbPlayer.scheduleBuffer(buffer!, completionHandler: nil)
        //echoPlayer.scheduleBuffer(buffer!, at: nil, completionHandler: nil)
        //pitchPlayer.scheduleBuffer(buffer!, at: nil, completionHandler: nil)
        
        
        audioEngine?.prepare()
        try! audioEngine?.start()
        
        reverbPlayer.play()
        //echoPlayer.play()
        //pitchPlayer.play()
        
       
        }

    
    
    
    
    
//    var audioPlayer : AVAudioEngine?
//
//
//    func playsound(soundName:String, rate:Double, pitch:Double, isOnlySoundPlaying:Bool){
//        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {return}
//
//        do {
//            audioPlayer = try AVAudioPlayer(contentsOf: url)
//            audioPlayer?.enableRate = true
//            audioPlayer?.rate = rate
//            audioPlayer.
//            audioPlayer?.play()
//        }catch{
//            print("Something Wrong with file")
//
//        }
//
//    }
    
    
    
    
    
    
    
    
}
