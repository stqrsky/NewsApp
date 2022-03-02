//
//  NewsImageView.swift
//  NewsApp
//
//  Created by star on 28.02.22.
//

import UIKit

class NewsImageView: UIImageView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFit
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  

}