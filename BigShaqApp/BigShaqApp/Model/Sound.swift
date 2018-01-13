//
//  Sound.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import Foundation


struct Sound {
    
    var name:String!
    var assetLbl:String!
    var pace:Double = 1
    var pitch:Double = 1
    var reverb:Double = 1
    var isOnlySoundPlaying = true
    
    init(name:String, assetLbl:String) {
        self.assetLbl = assetLbl
        self.name = name
    }
    
}
