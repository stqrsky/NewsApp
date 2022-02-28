//
//  DetailVC.swift
//  NewsApp
//
//  Created by star on 28.02.22.
//

import UIKit

class DetailVC: UIViewController {
    
    private let titleLabel = NewsLabel(fontStyle: .headline)
    private let imageView = UIImageView()
    private let infoLabel = NewsLabel(fontStyle: .footnote)
    private let contentLabel = NewsLabel(fontStyle: .body)
    private let readArticleButton = UIButton()
    
    private let stackView = UIStackView()

    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        let appearance = UINavigationBarAppearance()
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
    }

    init(article: Article) {
        super.init(nibName: nil, bundle: nil)
        self.article = article
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.addArrangedSubviews([titleLabel, imageView, infoLabel, contentLabel, readArticleButton])
        
        view.addSubview(stackView)
        stackView.pinToEdges(of: view, withPadding: 10)
        
    }
    
}
