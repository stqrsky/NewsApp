//
//  HomeFeedVC.swift
//  NewsApp
//
//  Created by star on 19.02.22.
//

import UIKit

class HomeFeedVC: UIViewController {
    enum Section {
        case main
    }
    
    private let tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Section, Article>!
    
    private var data: [Article] = []
    
    private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureDataSource()
        updateNewsItems()
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(updateNewsItems), for: .valueChanged)
    }
    
    @objc
    func updateNewsItems() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
        showLoadingSpinner()
        NetworkManager.shared.getNewsItems { (result) in
            switch result {
            case .success(let newsResponse):
                self.updateData(articles: newsResponse.articles)

            case .failure(let error):
                self.presentWarningAlert(title: "Fehler", message: error.rawValue)
            }
            
            self.dismissLoadingSpinner()
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
    
    func showLoadingSpinner() {
        containerView = UIView()
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.pinToEdges(of: view)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.85
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingSpinner() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
}


