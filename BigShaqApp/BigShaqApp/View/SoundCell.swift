//
//  SoundCell.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

class SoundCell: UICollectionViewCell {
    
    @IBOutlet weak var soundImg: UIImageView!
    @IBOutlet weak var soundLbl: UILabel!
    
    @IBOutlet weak var overlayView: UIView!
    
    
    func configureCell(sound:Sound){
        soundImg.image = UIImage(named:sound.assetLbl)
        soundLbl.text = sound.name.uppercased()
    }
    
    func animateOverlay(duration:TimeInterval){
        
        UIView.animate(withDuration: duration/2, animations: {
            self.overlayView.backgroundColor = #colorLiteral(red: 0.9107907678, green: 0.4508725945, blue: 0.2946264155, alpha: 0.5)})
        
        UIView.animate(withDuration: duration/2, animations: {
                self.overlayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            })
        
    }
    
    
    
    
    
}
