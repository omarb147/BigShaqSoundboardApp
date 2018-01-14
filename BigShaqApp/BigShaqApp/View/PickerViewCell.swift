//
//  PickerViewCell.swift
//  BigShaqApp
//
//  Created by Omar Bello on 13/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

@IBDesignable
class PickerViewCell: UITableViewCell,UIPickerViewDelegate,UIPickerViewDataSource {
    
    
    //Outlets
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var attributeLbl: UILabel!
    
    //Variables
    var isMasterCell:Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    func setupView(attribute:String, isMasterCell:Bool){
        attributeLbl.text = attribute
        self.isMasterCell = isMasterCell
        
        if isMasterCell{
            guard let selectedRow = SoundDataService.instance.masterSettings[attribute] else {return}
            self.pickerView.selectRow(Int(selectedRow), inComponent: 0, animated: true)
            
        }else{
            if attribute == "Reverb" {
//                guard let selectedRow = SoundDataService.instance.selectedSound?.reverb else {return}
//                self.pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
                
            }else if attribute == "Distortion"{
                
                guard let selectedRow = SoundDataService.instance.selectedSound?.distortion else {return}
                self.pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
                
            }else if attribute == "Sounds Displayed Per Row"{
                attributeLbl.font = UIFont(name: "Avenir Next", size: 12)
               let selectedRow = SoundDataService.instance.soundsPerRowSelected - 1
                self.pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
                
            
            
        }
    }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = UIColor.white
        label.font = UIFont(name: "AvenirNext", size: 12)
        label.textAlignment = .center
        
        var titleText = ""
        
        if attributeLbl.text! == "Reverb" {
            titleText = SoundDataService.instance.reverbEffectOptions[row]
        }else if attributeLbl.text == "Distortion"{
            titleText = SoundDataService.instance.distortionEffectOptions[row]
           
        } else if attributeLbl.text == "Sounds Displayed Per Row"{
            titleText = String(SoundDataService.instance.soundsPerRow[row])
        }
        
        label.text = titleText
        
    
        return label
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//
//        if attributeLbl.text! == "Reverb" {
//            let titleData = SoundDataService.instance.reverbEffectOptions[row]
//            let MyTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "AvenirNext-Regular", size:15.0) ?? UIFont.systemFont(ofSize: 15),NSAttributedStringKey.foregroundColor:UIColor.white ])
//
//            return MyTitle
//        }else if attributeLbl.text == "Distortion"{
//            let titleData = SoundDataService.instance.distortionEffectOptions[row]
//            let MyTitle = NSAttributedString(string: titleData, attributes: [ NSAttributedStringKey.font :UIFont(name: "AvenirNext", size:10) ?? UIFont.systemFont(ofSize: 10) ,NSAttributedStringKey.foregroundColor:UIColor.white ])
//            return MyTitle
//
//        } else if attributeLbl.text == "Sounds Displayed Per Row"{
//            let titleData = String(SoundDataService.instance.soundsPerRow[row])
//            let MyTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "AvenirNext-Regular", size:6.0) ?? UIFont.systemFont(ofSize: 6.0) ,NSAttributedStringKey.foregroundColor:UIColor.white ])
//            return MyTitle
//        }
//
//
//        else{
//            return NSAttributedString()
//        }
//    }
//

    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isMasterCell!{
            SoundDataService.instance.testMasterSettings[attributeLbl.text!] = Double(row)
        }else{
            if  attributeLbl.text == "Reverb" {
                //SoundDataService.instance.selectedSound?.reverb = row
            }else if attributeLbl.text == "Distortion"{
                SoundDataService.instance.selectedSound?.distortion = row
            }
            else if attributeLbl.text == "Sounds Displayed Per Row" {
                SoundDataService.instance.soundsPerRowSelected = row+1
                
            }
        }
        
    }
    
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if  attributeLbl.text == "Reverb" {
            return SoundDataService.instance.reverbEffectOptions.count
        }else if attributeLbl.text == "Distortion"{
            return SoundDataService.instance.distortionEffectOptions.count
        }else if attributeLbl.text == "Sounds Displayed Per Row" {
           return SoundDataService.instance.soundsPerRow.count
            
        }
        else{
            return 0 
        }
    }
    
    
    
    
}
