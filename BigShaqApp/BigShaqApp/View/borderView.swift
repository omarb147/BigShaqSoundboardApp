//
//  borderClass.swift
//  BigShaqApp
//
//  Created by Omar Bello on 12/01/2018.
//  Copyright © 2018 OmarBello. All rights reserved.
//

import UIKit

@IBDesignable
class borderView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutIfNeeded() {
        configureLayout()
        
    }
    
    override func prepareForInterfaceBuilder() {
        configureLayout()
    }
    
    
    func configureLayout(){
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.3891267123)
    }
    
    
    
    
}
