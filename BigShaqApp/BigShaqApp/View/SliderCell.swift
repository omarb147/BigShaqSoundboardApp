//
//  SliderCell.swift
//  BigShaqApp
//
//  Created by Omar Bello on 13/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

class SliderCell: UITableViewCell {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var attributeLbl: UILabel!
    @IBOutlet weak var sliderValueLbl: UILabel!
    
    //varibales
    var isMasterCell:Bool?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if isMasterCell! {
            SoundDataService.instance.testMasterSettings[attributeLbl.text!] = Double(sender.value)
            setSliderLblValue()
            
        }else{
            if attributeLbl.text! == "Rate"{
                SoundDataService.instance.selectedSound?.rate = sender.value
                setSliderLblValue()
            }
                
            else if attributeLbl.text! == "Echo" {
                SoundDataService.instance.selectedSound?.echo = Double(sender.value)
                setSliderLblValue()
            }
            else if attributeLbl.text! == "Reverb" {
                SoundDataService.instance.selectedSound?.reverb = Double(sender.value)
                setSliderLblValue()
            }
            
            
            
        }
        
        
        
       

    }
        
        
   
    func setupCell(attribute:String, isMasterCell:Bool) {
        attributeLbl.text = attribute
        self.isMasterCell = isMasterCell
        
        if attribute == "Rate"{
            slider.maximumValue = 3
            slider.minimumValue = 0.5
        }else if attribute == "Echo"{
            slider.maximumValue = 2
            slider.minimumValue = 0
            
        }else if attribute == "Reverb"{
            slider.maximumValue = 7
            slider.minimumValue = 0
        }
        if isMasterCell{
            slider.setValue(Float(SoundDataService.instance.masterSettings[attribute]!), animated: true)
            setSliderLblValue()
            
        }else{
            if attribute == "Rate" {
                slider.setValue((SoundDataService.instance.selectedSound?.rate)!, animated: true)
                setSliderLblValue()
            }
                
            else if attribute == "Echo"{
                slider.setValue(Float((SoundDataService.instance.selectedSound?.echo)!), animated: true)
                setSliderLblValue()
                
            }else if attribute == "Reverb"{
                slider.setValue(Float((SoundDataService.instance.selectedSound?.echo)!), animated: true)
                setSliderLblValue()
            }
            
        }
        
        
    }
    
    
    func setSliderLblValue(){
        let formattedSliderVal = String(format: "%.1f",slider.value)
        
        if attributeLbl.text! == "Rate" || attributeLbl.text! == "Reverb" {
        self.sliderValueLbl.text = "\(formattedSliderVal)x"
            
        }else if attributeLbl.text! == "Echo"{
        self.sliderValueLbl.text = "\(formattedSliderVal)s"
        }
    }
    

}
