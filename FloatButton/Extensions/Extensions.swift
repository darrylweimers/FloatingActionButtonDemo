//
//  Extensions.swift
//  FloatButton
//
//  Created by Darryl Weimers on 2020-12-26.
//

import UIKit

extension UIButton {
    func makeFloatingButtonAction(image: UIImage, tintColor: UIColor = .white, backgroundColor: UIColor = .blue) {
        self.setImage(image, for: .normal)
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor

        // drop shadow
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 5) // move down by 5 points
    }
}

extension UIView {
    func makeRectangleViewWithDropShadow(backgroundColor: UIColor = .blue) {
        self.backgroundColor = backgroundColor
        
        // drop shadow
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 5) // move down by 5 points
    }
}
