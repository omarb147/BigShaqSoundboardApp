//
//  ResetToDefaultsCell.swift
//  BigShaqApp
//
//  Created by Omar Bello on 14/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

class ResetCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView(description:String){
    cellLabel.text = description
        
    }
    
    func resetAllAudioEffectValues(){
        
        if cellLabel.text! == "Reset To Defaults"{
            
            SoundDataService.instance.resetSoundToMasterDefault(sound: SoundDataService.instance.selectedSound!)
       
            
        }else if cellLabel.text! == "Master Reset To Defaults" {
           
         SoundDataService.instance.masterResetForAllSounds()
            
            
        }else if cellLabel.text! == "Clear Favourites"{
            
            SoundDataService.instance.clearFavourites()
        }
        
        
    }
    
    
    

}
