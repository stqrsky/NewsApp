//
//  NewsButton.swift
//  NewsApp
//
//  Created by star on 28.02.22.
//

import UIKit

class NewsButton: UIButton {

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
