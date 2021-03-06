//
//  DetailVC.swift
//  NewsApp
//
//  Created by star on 28.02.22.
//

import UIKit
import SafariServices

class DetailVC: UIViewController {
    
    private let titleLabel = NewsLabel(fontStyle: .headline)
    private let imageView = NewsImageView(frame: .zero)
    private let infoLabel = NewsLabel(fontStyle: .footnote, textAlignment: .center)
    private let contentLabel = NewsLabel(fontStyle: .body)
    private let readArticleButton = NewsButton(backgroundColor: .systemBlue, title: "Zum ganzen Artikel")
    
    private let stackView = UIStackView()

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var article: Article! {
        didSet {
            guard let articles = articles, let currentIndex =
                    articles.firstIndex(of: article) else {
                        upButton.isEnabled = false
                        downButton.isEnabled = false
                        return
                    }
            
            if currentIndex == 0 {
                upButton.isEnabled = false
            } else {
                upButton.isEnabled = true
            }
            
            if currentIndex == articles.count - 1 {
                downButton.isEnabled = false
            } else {
                downButton.isEnabled = true
            }
        }
    }
    private var articles: [Article]?
    
    let config = UIImage.SymbolConfiguration(pointSize: 21, weight: .semibold)
    lazy var upButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up", withConfiguration: config), style: .plain, target: self, action: #selector(handleUpButtonDidTap))
    
    lazy var downButton = UIBarButtonItem(image: UIImage(systemName: "arrow.down", withConfiguration: config), style: .plain, target: self, action: #selector(handleDownButtonDidTap))
    
    lazy var favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star", withConfiguration: config), style: .plain, target: self, action: #selector(handleFavoriteButtonDidTap))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        configureUI()
        setElements(article: article)
        configureReadArticleButton()
        
        navigationItem.rightBarButtonItems = [downButton, upButton, favoriteButton]
        
//        let appearance = UINavigationBarAppearance()
//        navigationItem.standardAppearance = appearance
//        navigationItem.scrollEdgeAppearance = appearance
    }

    init(article: Article, articles: [Article]) {
        super.init(nibName: nil, bundle: nil)
        
        ({
            self.articles = articles
            self.article = article
        })()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleFavoriteButtonDidTap() {
        if PersistenceManager.shared.isArticleAlreadyFavorite(article: article) {
            PersistenceManager.shared.removeFavoriteArticle(article: article) {
                favoriteButton.image = UIImage(systemName: "star", withConfiguration: config)
                NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
            }
            
        } else {
            PersistenceManager.shared.addFavoriteArticle(article: article) {
                favoriteButton.image = UIImage(systemName: "star.fill", withConfiguration: config)
                NotificationCenter.default.post(name: .favoritesDidChange, object: nil)
            }
            
        }
        
    }
    
    @objc
    private func handleUpButtonDidTap() {
        guard let currentIndex = articles?.firstIndex(of: article),
            let nextArticle = articles?[currentIndex - 1] else { return }
        article = nextArticle
        setElements(article: article)
        
    }
    
    @objc
    private func handleDownButtonDidTap() {
        guard let currentIndex = articles?.firstIndex(of: article),
            let nextArticle = articles?[currentIndex + 1] else { return }
        article = nextArticle
        setElements(article: article)
        
    }
    
    private func configureReadArticleButton() {
        readArticleButton.addTarget(self, action: #selector(handleReadArticleButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    private func handleReadArticleButtonDidTap() {
        guard let url = URL(string: article.url ?? "") else {
            presentWarningAlert(title: "Fehler", message: "Die gew??nschte URL konnte nicht ge??ffnet werden.")
            return
        }
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let safariVC = SFSafariViewController(url: url, configuration: config)
        present(safariVC, animated: true)
    }
    
    private func configureUI() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.pinToEdges(of: view, considerSafeArea: true)
        
        scrollView.addSubview(contentView)
        contentView.pinToEdges(of: scrollView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        
        contentView.addSubview(stackView)
        stackView.pinToEdges(of: contentView, withPadding: 10, considerSafeArea: true)
        
    }
    
    func setElements(article: Article) {
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubviews([titleLabel, imageView, infoLabel, contentLabel, readArticleButton])
        
        self.titleLabel.text = article.title
        self.contentLabel.text = article.content == nil || article.content == "" ? article.description : article.content
        self.infoLabel.text = "Autor: \(article.author ?? "N/A") / \(article.publishedAt?.getStringRepresentation() ?? "N/A") Uhr"
        
        
        self.imageView.setImage(urlString: article.urlToImage)
        
        favoriteButton.image = PersistenceManager.shared.isArticleAlreadyFavorite(article: article) ? UIImage(systemName: "star.fill", withConfiguration: config) : UIImage(systemName: "star", withConfiguration: config)
    }
    
}
