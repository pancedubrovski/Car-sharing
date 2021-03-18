//
//  RoundLabel.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 12.2.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import UIKit

class RoundLabel: UILabel {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
       //    backgroundColor = .white
           layer.cornerRadius = 20
           layer.borderWidth = 1.2
         //  layer.borderColor = UIColor.white.cgColor
           clipsToBounds = true
    }
    

}
