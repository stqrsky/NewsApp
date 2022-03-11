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
        tableView.tableFooterView = UIView()
        tableView.refreshControl = nil
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesDidChange), name: Notification.Name("favoritesDidChange"), object: nil)
    }
    
    @objc
    func favoritesDidChange() {
        updateNewsItems()
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
