//
//  SoundService.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import Foundation


class SoundDataService {
    
    
    static var instance = SoundDataService()
    
    var favouriteSounds = [Sound]()
    var allSounds = [Sound]()
    var selectedSound:Sound?
    var masterSettings:Dictionary<String,Double> = ["Echo":0 , "Reverb":0, "Distortion":0, "Rate":1]
    var testMasterSettings:Dictionary<String,Double> = ["Echo":0 , "Reverb":0, "Distortion":0, "Rate":1]
    var testSound:Sound?
    
    var soundsPerRow = [1,2,3,4]
    var soundsPerRowSelected = 2
    
    var distortionEffectOptions = ["No Distortion Effect", "Drums Bit Brush", "Drums Buffer Beats", "Drums Lofi", "Broken Speaker","Decimated 1", "Decimated 2","Decimated 3", "Decimated 4", "Distorted Funk","Distorted Cubed", "Multi-Distorted Squared", "Echo 1", "Echo 2", "Echo Tight 1", "cho-Tight 2", "Everything is Broken", "Speech Alien Chatter", "Speech Cosmic Interfernece", "Speech Golden Pi", "Speech Radio Tower", "Speech Waves"]
    
    var reverbEffectOptions = ["No Reverb Effect","Small Room", "Medium Room", "Large Room", "Medium Hall", "Large Hall", "Plate", "Medium Chamber", "Large Chamber", "Cathedral", "Large Room 2", "Medium Hall 2", "Medium Hall 2", "Medium Hall 3", "Large Hall 2"]
    
    
    func populateSounds() {
        allSounds.append(Sound(name: "trap,trap,trap", assetLbl: "trap"))
        allSounds.append(Sound(name: "big shaq", assetLbl:"bigshaq"))
        allSounds.append(Sound(name: "Asnee", assetLbl: "asnee"))
        allSounds.append(Sound(name: "He's Got The Frizbee", assetLbl:"frizbee"))
        allSounds.append(Sound(name: "Quack,Quack,Quack", assetLbl: "ducking"))
        allSounds.append(Sound(name: "boom", assetLbl:"boom"))
        allSounds.append(Sound(name: "Fire in the booth", assetLbl:"fireinthebooth"))
        allSounds.append(Sound(name: "No Ketchup", assetLbl:"noketchup"))
        allSounds.append(Sound(name: "Llama Toes", assetLbl:"llamatoes"))
        allSounds.append(Sound(name: "mans Not hot", assetLbl:"mansnothot"))
        allSounds.append(Sound(name: "Neva Hot", assetLbl:"nevahot"))
        allSounds.append(Sound(name: "No Ketchup", assetLbl:"noketchup"))
        allSounds.append(Sound(name: "Oosnah", assetLbl:"oosnah"))
        allSounds.append(Sound(name: "Quick Maths", assetLbl:"quickmaths"))
        allSounds.append(Sound(name: "Rice Krispies", assetLbl:"ricekrispies"))
        allSounds.append(Sound(name: "Skutnu", assetLbl:"skutnu"))
        allSounds.append(Sound(name: "Twix by Force", assetLbl:"twixbyforce"))
        allSounds.append(Sound(name: "You Dickhead", assetLbl:"youdickhead"))
        
        
    }
    
    
    func MakeTestSound(){
        
        
    }
    
    func SetMasterEffectsForAllSounds(){
        
        guard let distortion = SoundDataService.instance.masterSettings["Distortion"] else {return}
        guard let echo = SoundDataService.instance.masterSettings["Echo"] else {return}
        guard let rate = SoundDataService.instance.masterSettings["Rate"] else {return}
        guard let reverb = SoundDataService.instance.masterSettings["Reverb"] else {return}
        
        for sound in allSounds{
            setAllEffectsForSound(sound: sound, reverb: reverb, distortion: Int(distortion), echo: echo, rate:Float(rate))
        }
        
        testMasterSettings = masterSettings
        
    }
    
    func setAllEffectsForSound(sound:Sound,reverb:Double,distortion:Int,echo:Double,rate:Float){
        sound.distortion = distortion
        sound.echo = echo
        sound.reverb = reverb
        sound.rate = rate
        
    }
    
    func getMasterSettingsValues()-> (Int,Double,Double,Float){
       let distortion = SoundDataService.instance.masterSettings["Distortion"]
       let echo = SoundDataService.instance.masterSettings["Echo"]
       let rate = SoundDataService.instance.masterSettings["Rate"]
       let reverb = SoundDataService.instance.masterSettings["Reverb"]
        
        return (Int(distortion!), Double(reverb!), Double(echo!), Float(rate!))
        
    
    }
    
    
    func getTestMasterSettingsValues()-> (Int,Double,Double,Float){
        let distortion = SoundDataService.instance.testMasterSettings["Distortion"]
        let echo =  SoundDataService.instance.testMasterSettings["Echo"]
        let rate = SoundDataService.instance.testMasterSettings["Rate"]
        let reverb = SoundDataService.instance.testMasterSettings["Reverb"]
        
        return (Int(distortion!), Double(reverb!), Double(echo!), Float(rate!))
        
        
    }
    
    func removeSoundFromFavourites(sound:Sound){
        if favouriteSounds.contains(where: { (soundInFav) -> Bool in
            return soundInFav.name == sound.name
        }){
        SoundDataService.instance.favouriteSounds = SoundDataService.instance.favouriteSounds.filter{$0.name != sound.name}
        }
    }
    
    func clearFavourites(){
        for sound in SoundDataService.instance.favouriteSounds{
            sound.isFavourite = false
        }
    SoundDataService.instance.favouriteSounds.removeAll()
    }
    
    func masterResetForAllSounds(){
        SoundDataService.instance.masterSettings["Reverb"] = 0
        SoundDataService.instance.masterSettings["Distortion"] = 0
        SoundDataService.instance.masterSettings["Rate"] = 1
        SoundDataService.instance.masterSettings["Echo"] = 0
        
        SoundDataService.instance.SetMasterEffectsForAllSounds()
    }
    
    func resetSoundToMasterDefault(sound:Sound){
        let (distortion, reverb, echo, rate) = SoundDataService.instance.getMasterSettingsValues()
        
        sound.distortion = distortion
        sound.reverb = reverb
        sound.echo = echo
        sound.rate = rate
        
    }
    
    func setMastertoTestSettings(){
        SoundDataService.instance.masterSettings = SoundDataService.instance.testMasterSettings
        
        SoundDataService.instance.SetMasterEffectsForAllSounds()
    }
    
    
    
}
