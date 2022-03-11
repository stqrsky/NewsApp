//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by star on 11.03.22.
//

import UIKit

class FavoriteVC: HomeFeedVC {

    private let emptyStateView = EmptyStateView(imageSystemName: "star", text: "Es sind keine Favoriten verfügbar")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.refreshControl = nil
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateNewsItems), name: .favoritesDidChange, object: nil)
    }

    
    override func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Favoriten"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func updateNewsItems() {
        self.articles = PersistenceManager.shared.getAllFavoriteArticles()
        updateData(articles: articles)
        
        if articles.isEmpty {
            tableView.backgroundView = emptyStateView
        } else {
            tableView.backgroundView = nil
        }
    }

}
