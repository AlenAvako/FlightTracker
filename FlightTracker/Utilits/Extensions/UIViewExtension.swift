//
//  UIViewExtension.swift
//  FlightTracker
//
//  Created by Ален Авако on 02.06.2022.
//


import UIKit

public extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for subview in subviews {
            self.addSubview(subview)
        }
    }
    
    func toAutoLayout() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
