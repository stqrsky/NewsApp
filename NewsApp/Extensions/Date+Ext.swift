//
//  Date+Ext.swift
//  NewsApp
//
//  Created by star on 22.02.22.
//

import Foundation

extension Date {
    func getStringRepresentation() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd. MMM yyy - HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
