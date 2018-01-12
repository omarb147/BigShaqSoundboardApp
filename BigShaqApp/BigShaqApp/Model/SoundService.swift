//
//  SoundService.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import Foundation


class SoundService {
    
    
    static var instance = SoundService()
    
    var favouriteSounds = [Sound]()
    var allSounds = [Sound]()
    
    
    func populateSounds(){
        allSounds.append(Sound(name: "trap,trap,trap", assetLbl: "trap"))
        allSounds.append(Sound(name: "big shaq", assetLbl:"bigshaq"))
        allSounds.append(Sound(name: "Asnee", assetLbl: "asnee"))
        allSounds.append(Sound(name: "He's Got The Frizbee", assetLbl:"frizbee"))
        allSounds.append(Sound(name: "You Man Were Ducking", assetLbl: "ducking"))
        allSounds.append(Sound(name: "boom", assetLbl:"boom"))
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
}
