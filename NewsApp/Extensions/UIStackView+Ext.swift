//
//  UIStackView+Ext.swift
//  NewsApp
//
//  Created by star on 28.02.22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { (view) in
            self.addArrangedSubview(view)
        }
    }
}
