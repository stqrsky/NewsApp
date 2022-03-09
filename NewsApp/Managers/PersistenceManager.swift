//
//  PersistenceManager.swift
//  NewsApp
//
//  Created by star on 07.03.22.
//

import Foundation

class PersistenceManager {
    static let shared = PersistenceManager()
    private init() {}
    
    private let articlesKey = "Articles_UserDefault"
    
    func addFavoriteArticle(article: Article) {
        var favorites = getAllFavoriteArticles()
        
        favorites.append(article)
        save(articles: favorites)
    }
    
    func getAllFavoriteArticles() -> [Article] {
        guard let favoriteData = UserDefaults.standard.object(forKey: articlesKey) as? Data,
              let articles = try? JSONDecoder().decode([Article].self, from: favoriteData)
        else { return [] }
        
        return articles
    }
    
    func save(articles: [Article]) {
        guard let dataToSave = try? JSONEncoder().encode(articles) else {
            return }
        
        UserDefaults.standard.set(dataToSave, forKey: articlesKey)
    }
    
}
