//
//  RemixVC.swift
//  BigShaqApp
//
//  Created by Omar Bello on 13/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

class RemixVC: UIViewController {

    //Variables
    
    
    //Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var soundBtn: UIButton!
    @IBOutlet weak var soundLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        soundBtn.imageView?.image = UIImage(named:(SoundDataService.instance.selectedSound?.assetLbl)!)
        soundLbl.text = SoundDataService.instance.selectedSound?.name.capitalized
    }
    
    
    @IBAction func soundBtnPressed(_ sender: Any) {
        AudioPlayerService.instance.playsound(soundName:(SoundDataService.instance.selectedSound?.assetLbl)!)
        
    }
    
    
    
    

}
