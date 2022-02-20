//
//  ViewController.swift
//  NewsApp
//
//  Created by star on 19.02.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hey guys"
        label.tintColor = .systemRed
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        configureUI()
        
    }
    
    private func configureUI() {
        label.text = "Enjoy everybody!"
//        label.textAlignment = .center
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//            label.widthAnchor.constraint(equalToConstant: 200),
//            label.heightAnchor.constraint(equalToConstant: 20)
        ])
    }


}

