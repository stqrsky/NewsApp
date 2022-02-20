//
//  UIView+Ext.swift
//  NewsApp
//
//  Created by star on 20.02.22.
//

import UIKit

extension UIView {
    func pinToEdges(of superview: UIView, withPadding padding: CGFloat = 0) {
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding)
        ])
    }
}
