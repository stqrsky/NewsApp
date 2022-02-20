//
//  Articles.swift
//  NewsApp
//
//  Created by star on 20.02.22.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String
    let title: String
    let description: String?
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String

}

// MARK: - Source
struct Source: Codable {
    let id: ID
    let name: Name
}

enum ID: String, Codable {
    case techcrunch = "techcrunch"
}

enum Name: String, Codable {
    case techCrunch = "TechCrunch"
}
