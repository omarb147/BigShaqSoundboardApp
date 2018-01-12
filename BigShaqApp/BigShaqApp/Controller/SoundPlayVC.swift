//
//  ViewController.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit
import AVFoundation

class SoundPlayVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{

    
    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Variables
    var audioPlayer : AVAudioPlayer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoundService.instance.populateSounds()
        
        
      
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //Set up collectionViewlayout
        let layout = UICollectionViewFlowLayout()
        let celldimension = UIScreen.main.bounds.width/3
        
        layout.itemSize = CGSize(width: celldimension, height: celldimension)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.collectionViewLayout = layout
        
    }


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SoundService.instance.allSounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SoundCell", for: indexPath) as? SoundCell else {return UICollectionViewCell() }
        
        cell.configureCell(sound: SoundService.instance.allSounds[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let soundAssetName = SoundService.instance.allSounds[indexPath.row].assetLbl else {return}
        guard let cell = collectionView.cellForItem(at: indexPath) as? SoundCell else {return}
        
        cell.animateOverlay(duration: 0.2)
        playsound(soundName:soundAssetName)
        
        
        
    }
    
    
    
    func playsound(soundName:String){
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {return}
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.enableRate = true
            audioPlayer?.rate = 0.5
            audioPlayer?.play()
        }catch{
            print("Something Wrong with file")
        
        }
        
    }
    
    
    
    
    
    
    

}

