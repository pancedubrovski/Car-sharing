//
//  CustomScakView.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 11.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit

class CustomScakView: UIStackView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        backgroundColor = .white
        
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.shadowRadius = 10
        clipsToBounds = true
    }
    
    

}
