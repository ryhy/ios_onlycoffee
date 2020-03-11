//
//  ShadowButton.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {

    private var shadowLayer: CAShapeLayer!
    
    override func draw(_ rect: CGRect) {
//        updateLayerProperties()
    }
//
//    func updateLayerProperties() {
//        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowOpacity = 1.0
//        self.layer.shadowRadius = 10.0
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = 13
//        self.clipsToBounds = false
//    }
//
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 3).cgPath
            shadowLayer.fillColor = UIColor.black.cgColor
            shadowLayer.shadowColor = UIColor.lightGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            shadowLayer.borderColor = UIColor.black.cgColor
            shadowLayer.borderWidth = 5
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
}
