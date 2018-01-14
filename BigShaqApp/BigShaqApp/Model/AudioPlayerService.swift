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

    
    func playsound(sound:Sound){
        
        audioEngine = AVAudioEngine()
        reverbPlayer = AVAudioPlayerNode()
        echoPlayer = AVAudioPlayerNode()
        pitchPlayer = AVAudioPlayerNode()
        
        
        guard let url = Bundle.main.url(forResource: sound.assetLbl, withExtension: "mp3") else {return}
        let file = try? AVAudioFile(forReading: url)
        let buffer = AVAudioPCMBuffer(pcmFormat: file!.processingFormat, frameCapacity: AVAudioFrameCount(file!.length))
        try! file!.read(into: buffer!)
        

        let reverbNode = AVAudioUnitReverb()
        let echoNode = AVAudioUnitDelay()
        let pitchNode = AVAudioUnitTimePitch()
        let distortionNode = AVAudioUnitDistortion()
        
        
        //SetUp Effects
        
        switch sound.distortion {
        case 0:
            distortionNode.wetDryMix = 0
        case let val where val > 0 :
            let presetNumber = sound.distortion - 1
            guard let effect =  AVAudioUnitDistortionPreset(rawValue: presetNumber) else {return}
            distortionNode.loadFactoryPreset(effect)
        default:
            return
        }
        
        let reverbMuliplier = pow(sound.reverb,sound.reverb)
        reverbNode.wetDryMix = Float(reverbMuliplier)
       
        
        
        
//        
//        
//        if sound.distortionIsOn {
//            distortionNode.loadFactoryPreset(sound.distortion)
//        }else{
//            distortionNode.wetDryMix = 0
//        }
//        
        
        
        
//
//            reverbNode.loadFactoryPreset(sound.reverb)
//        }else{
//            reverbNode.wetDryMix = 0
//        }
//
        pitchNode.rate = sound.rate
        echoNode.delayTime = sound.echo
        
        
        
        audioEngine?.attach(reverbPlayer)
        audioEngine?.attach(echoPlayer)
        audioEngine?.attach(pitchPlayer)
        audioEngine?.attach(reverbNode)
        audioEngine?.attach(echoNode)
        audioEngine?.attach(pitchNode)
        audioEngine?.attach(distortionNode)
        
    
            
        audioEngine?.connect(reverbPlayer, to: reverbNode, format:buffer?.format)
        audioEngine?.connect(reverbNode, to: echoNode, format: buffer?.format)
        audioEngine?.connect(echoNode, to: pitchNode, format: buffer?.format)
        audioEngine?.connect(pitchNode, to: distortionNode, format: buffer?.format)
        audioEngine?.connect(distortionNode, to: (audioEngine?.mainMixerNode)!, format:buffer?.format)
        
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
