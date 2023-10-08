//
//  UIView+Extensions.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 8.10.2023.
//

import UIKit

extension UIView {
    func setGradientBackground(color1: UIColor, color2: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
