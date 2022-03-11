//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by star on 11.03.22.
//

import UIKit

class FavoriteVC: HomeFeedVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
    }
    
    override func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favoriten"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func updateNewsItems() {
        self.articles = PersistenceManager.shared.getAllFavoriteArticles()
        updateData(articles: articles)
    }

}
