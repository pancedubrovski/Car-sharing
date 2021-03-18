//
//  Pom.swift
//  ProektMA
//
//  Created by PANCE DUBROVSKI on 8.1.21.
//  Copyright © 2021 PANCE DUBROVSKI. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI


class ShadowView : UIView {
    override var bounds: CGRect {
        didSet {
                setUpShadow()
        }
    }
    private func setUpShadow(){
        
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
}
