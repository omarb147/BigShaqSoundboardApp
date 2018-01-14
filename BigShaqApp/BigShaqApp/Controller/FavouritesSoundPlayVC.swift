//
//  FavouritesSoundPlayVC.swift
//  BigShaqApp
//
//  Created by Omar Bello on 14/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

class FavouritesSoundPlayVC: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if SoundDataService.instance.favouriteSounds.count > 0{
        setupViewCollection()
        }
        let longPressRemixGestureRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecoginser:)))
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        longPressRemixGestureRecogniser.delegate = self
        longPressRemixGestureRecogniser.minimumPressDuration = 1
        longPressRemixGestureRecogniser.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressRemixGestureRecogniser)
        
        
        
        //Set up collectionViewlayout
       
        

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
       
        if SoundDataService.instance.favouriteSounds.count > 0{
            setupViewCollection()
        }
        collectionView.reloadData()
        
    }
    //CollectionView Functions
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SoundDataService.instance.favouriteSounds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SoundCell", for: indexPath) as? SoundCell else {return UICollectionViewCell() }
        
        cell.configureCell(sound: SoundDataService.instance.favouriteSounds[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sound = SoundDataService.instance.favouriteSounds[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? SoundCell else {return}
        
        cell.animateOverlay(duration: 0.2)
        AudioPlayerService.instance.playsound(sound:sound)
        
        
        
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func setupViewCollection(){
        
        let numberItemsPerRow = CGFloat(SoundDataService.instance.soundsPerRowSelected)
        let layout = UICollectionViewFlowLayout()
        let celldimension = UIScreen.main.bounds.width/numberItemsPerRow
        
        layout.itemSize = CGSize(width: celldimension, height: celldimension)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
    
    //Segue Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @objc func handleLongPress(gestureRecoginser:UILongPressGestureRecognizer){
    
        if gestureRecoginser.state != UIGestureRecognizerState.ended {
            return
        }
        
        let point = gestureRecoginser.location(in: self.collectionView)
        
        if let indexPath = self.collectionView.indexPathForItem(at: point) as NSIndexPath? {
            SoundDataService.instance.selectedSound = SoundDataService.instance.favouriteSounds[indexPath.row]
            performSegue(withIdentifier: TO_REMIX_VC, sender: nil)
            
            
        }
        
    }
    
    
}
