//
//  FavoriteVC.swift
//  NewsApp
//
//  Created by star on 11.03.22.
//

import UIKit

class FavoriteNewsItemDataSource: UITableViewDiffableDataSource<HomeFeedVC.Section, Article> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let article = itemIdentifier(for: indexPath) {
                var snapshot = self.snapshot()
                snapshot.deleteItems([article])
                apply(snapshot)
                
                PersistenceManager.shared.removeFavoriteArticle(article: article) {
                    NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
                }
            }
        }
    }
}

class FavoriteVC: HomeFeedVC {

    private let emptyStateView = EmptyStateView(imageSystemName: "star", text: "Es sind keine Favoriten verfügbar")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.refreshControl = nil
        navigationItem.rightBarButtonItem = editButtonItem
        NotificationCenter.default.addObserver(self, selector: #selector(updateNewsItems), name: .favoritesDidChange, object: nil)
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
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
    
    override func configureDataSource() {
        dataSource = FavoriteNewsItemDataSource(tableView: tableView, cellProvider: { (tableView, indexPath, article) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as? NewsTableViewCell
            
            cell?.setCell(article: article)
            return cell
        })
    }

}
