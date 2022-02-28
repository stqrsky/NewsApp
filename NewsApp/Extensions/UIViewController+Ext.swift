//
//  UIViewController+Ext.swift
//  NewsApp
//
//  Created by star on 28.02.22.
//

import UIKit

extension UIViewController {
    func presentWarningAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
