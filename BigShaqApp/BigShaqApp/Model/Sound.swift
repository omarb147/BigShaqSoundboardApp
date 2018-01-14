//
//  Sound.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import Foundation
import AVFoundation


class Sound {
    
    var name:String!
    var assetLbl:String!
    var rate:Float = 1
    var echo:Double = 0
    var reverb:Double = 0
    var distortion:Int = 0 
    var isRemixed = false
    var isFavourite = false
    var isOnlySoundPlaying = true
    
    init(name:String, assetLbl:String) {
        self.assetLbl = assetLbl
        self.name = name
    }

    
    
    
    
}
