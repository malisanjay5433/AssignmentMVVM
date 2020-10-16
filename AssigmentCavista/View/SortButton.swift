//
//  SortButton.swift
//  AssigmentCavista
//
//  Created by Sanjay Mali on 16/10/20.
//  Copyright © 2020 theappmaker. All rights reserved.
//

import UIKit

class SortButton: UIButton {
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            let gradientLayer = CAGradientLayer()
            let rightColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
            let leftColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
            gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x:1, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at:0)
            layer.cornerRadius = 5
//            rect.height / 2
            clipsToBounds = true
            gradientLayer.frame = rect
        }
}
