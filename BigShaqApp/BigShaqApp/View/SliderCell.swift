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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
