//
//  NewsLabel.swift
//  NewsApp
//
//  Created by star on 22.02.22.
//

import Foundation
import UIKit


class NewsLabel: UILabel {
    
    init(fontStyle: UIFont.TextStyle, numberOfLines: Int = 0) {
        super.init(frame: .zero)
        
        self.font = UIFont.preferredFont(forTextStyle: fontStyle)
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
