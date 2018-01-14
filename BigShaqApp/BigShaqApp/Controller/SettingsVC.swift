//
//  SettingsVC.swift
//  BigShaqApp
//
//  Created by Omar Bello on 14/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TableViewFunctions
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        else {
            return 2
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.2963413639, green: 0.3235402177, blue: 0.3118630239, alpha: 1)
        let headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width:
            tableView.bounds.size.width, height: 20))
        headerLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.textColor = UIColor.white
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "   Settings For All Tracks"
        }else{
            return "   Other Settings"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
            
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SLIDER_CELL_ID) as? SliderCell else{return UITableViewCell()}
            
                cell.setupCell(attribute:"Rate",isMasterCell: true)
                cell.selectionStyle = .none
                return cell
            
            }
            if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SLIDER_CELL_ID) as? SliderCell else{return UITableViewCell()}
            
                cell.setupCell(attribute:"Echo",isMasterCell: true)
                cell.selectionStyle = .none
                return cell
            }
            if indexPath.row == 2 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SLIDER_CELL_ID) as? SliderCell else{return UITableViewCell()}
                
                cell.setupCell(attribute:"Reverb",isMasterCell: true)
                cell.selectionStyle = .none
                return cell
                
            }
        
            if indexPath.row == 3 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PICKER_VIEW_CELL_ID) as? PickerViewCell else{return UITableViewCell()}
                cell.setupView(attribute: "Distortion",isMasterCell: true)
                cell.selectionStyle = .none
                return cell
            
            }
          
            if indexPath.row == 4 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RESET_CELL) as? ResetCell else{return UITableViewCell()}
                cell.setupView(description:"Master Reset To Defaults")
                cell.selectionStyle = .none
                return cell
            } else{ return UITableViewCell()
        
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PICKER_VIEW_CELL_ID) as? PickerViewCell else{return UITableViewCell()}
                
                cell.setupView(attribute: "Sounds Displayed Per Row" ,isMasterCell: false)
                cell.selectionStyle = .none
                return cell
                
            }else if indexPath.row == 1{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RESET_CELL) as? ResetCell else{return UITableViewCell()}
                cell.setupView(description:"Clear Favourites")
                cell.selectionStyle = .none
                return cell
            }else{
                return UITableViewCell()
            }
            
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            if indexPath.row == 4 {
            
                createAlertForTableViewReset(title: "Reset To Default", message: "Are you sure that you would like to reset sound effects for all sounds", indexPath:indexPath)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 1{
                print("startcount",SoundDataService.instance.favouriteSounds.count)
                createAlertForTableViewReset(title: "Clear Favourites", message: "Are you sure that you would like to remove all sounds from favourites", indexPath:indexPath)
                print("endcount",SoundDataService.instance.favouriteSounds.count)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 0 {
            return CGFloat(integerLiteral: 60)
        }else {
            return UITableViewAutomaticDimension
        }
    }
    
    @IBAction func PreviewSoundBttnPressed(_ sender: Any) {
       let SoundInstance = SoundDataService.instance
        let testSound = SoundInstance.testSound
        let (distortion, reverb, echo, rate) = SoundInstance.getTestMasterSettingsValues()
        
        SoundDataService.instance.setAllEffectsForSound(sound: testSound!, reverb: reverb, distortion: distortion, echo: echo, rate: rate)
        AudioPlayerService.instance.playsound(sound: testSound!)
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applySettingsToAllSoundsPressed(_ sender: Any) {
        
        let alert = UIAlertController(title:"Apply Effects To All Sounds", message: "Are you sure to overide the Effects for all sounds?", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            SoundDataService.instance.setMastertoTestSettings()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
   
    
    
    //Alert SetUps
    
    func createAlertForTableViewReset(title:String, message:String, indexPath:IndexPath){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
            guard let cell = self.tableView.cellForRow(at: indexPath) as? ResetCell else {return}
            cell.resetAllAudioEffectValues()
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
}
