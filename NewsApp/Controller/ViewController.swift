//
//  ViewController.swift
//  NewsApp
//
//  Created by star on 19.02.22.
//

import UIKit

class ViewController: UIViewController {
    enum Section {
        case main
    }
    
    private let tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section, Article>!
    
    private var data: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureDataSource()
        
        NetworkManager.shared.getNewsItems { (result) in
            switch result {
            case .success(let newsResponse):
//                self.data = newsResponse.articles
                
                self.updateData(articles: newsResponse.articles)
//                response.articles.forEach { (article) in
//                    print(article.title ?? "N/A")
//                }
                
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Nachrichten"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.pinToEdges(of: view)
        
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseID)
    }

    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Article>(tableView: tableView, cellProvider: { (tableView, indexPath, article) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseID, for: indexPath) as? NewsTableViewCell
            
            cell?.setCell(article: article)
            
            return cell
        })
    }
    
    func updateData(articles: [Article]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Article>()
        snapshot.appendSections([.main])
        snapshot.appendItems(articles)
        self.dataSource.apply(snapshot)
    }
    
}


