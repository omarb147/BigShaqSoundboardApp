//
//  RemixVC.swift
//  BigShaqApp
//
//  Created by Omar Bello on 13/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

class RemixVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //Variables
    let animationTime:Double = 2
    
    //Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var soundBtn: UIButton!
    @IBOutlet weak var soundLbl: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
        setupView()
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupView(){
        soundBtn.setImage(UIImage(named:(SoundDataService.instance.selectedSound?.assetLbl)!), for: .normal)
        soundLbl.text = SoundDataService.instance.selectedSound?.name.uppercased()
        if (SoundDataService.instance.selectedSound?.isFavourite)! {
            favouriteBtn.setImage(UIImage(named:"star1"), for: .normal)
        }else{
            favouriteBtn.setImage(UIImage(named:"star0"), for: .normal)
        }
    }
    
    
    @IBAction func soundBtnPressed(_ sender: Any) {
        AudioPlayerService.instance.playsound(sound:(SoundDataService.instance.selectedSound)!)
        
    }
    
    //TableViewFunctions
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SLIDER_CELL_ID) as? SliderCell else{return UITableViewCell()}
            
            cell.setupCell(attribute:"Rate",isMasterCell: false)
            cell.selectionStyle = .none
            return cell
        
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SLIDER_CELL_ID) as? SliderCell else{return UITableViewCell()}
            
            cell.setupCell(attribute:"Echo",isMasterCell: false)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SLIDER_CELL_ID) as? SliderCell else{return UITableViewCell()}
            
            cell.setupCell(attribute:"Reverb",isMasterCell: false)
            cell.selectionStyle = .none
            return cell
        }
        if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PICKER_VIEW_CELL_ID) as? PickerViewCell else{return UITableViewCell()}
            cell.setupView(attribute: "Distortion",isMasterCell: false)
            cell.selectionStyle = .none
            return cell
            
        }
    
        if indexPath.row == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier:RESET_CELL) as? ResetCell else{return UITableViewCell()}
            cell.setupView(description: "Reset To Defaults")
            return cell
        }
        
        else{
    return UITableViewCell()
    }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 4 {
            guard let cell = tableView.cellForRow(at: indexPath) as? ResetCell else {return}
            cell.resetAllAudioEffectValues()
            tableView.reloadData()
            
        }
    }
    

    @IBAction func favouriteBtnPressed(_ sender: Any) {
        let overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
        
        let imageViewDimensions = UIScreen.main.bounds.width - 200
        
        let overlayImageView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - imageViewDimensions)/2, y: (UIScreen.main.bounds.height - imageViewDimensions)/2, width: imageViewDimensions, height: imageViewDimensions))
        
        if SoundDataService.instance.selectedSound?.isFavourite == false{
            overlayImageView.image = UIImage(named:"favourites0")
            favouriteBtn.setImage(UIImage(named:"star1"), for: .normal)
            SoundDataService.instance.favouriteSounds.append(SoundDataService.instance.selectedSound!)
            SoundDataService.instance.selectedSound?.isFavourite = true
            
        }else{
            overlayImageView.image = UIImage(named:"favourites1")
            favouriteBtn.setImage(UIImage(named:"star0"), for: .normal)
            SoundDataService.instance.removeSoundFromFavourites(sound: SoundDataService.instance.selectedSound!)
            SoundDataService.instance.selectedSound?.isFavourite = false
            
        }
        
        print(SoundDataService.instance.favouriteSounds)
        
        UIView.animate(withDuration: 0.6, animations: {
            self.view.addSubview(overlayView)
            self.view.addSubview(overlayImageView)
            overlayView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7598726455)
        }) { (success) in
            UIView.animate(withDuration: 0.6, animations: {
                overlayView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                overlayImageView.removeFromSuperview()
                overlayView.removeFromSuperview()
            })
        }
        
        
    }
}
