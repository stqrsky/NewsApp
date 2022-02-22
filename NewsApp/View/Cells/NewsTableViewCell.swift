//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by star on 20.02.22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let reuseID = "newsCell"
    
    private let titleLabel = NewsLabel(fontStyle: .headline)
    
    private let subtitleLabel = NewsLabel(fontStyle: .subheadline)
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(titleStackView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(subtitleLabel)
    }
    
    func setCell(article: Article) {
        titleLabel.text = article.title ?? "N/A"
        subtitleLabel.text = "\(article.publishedAt?.getStringRepresentation() ?? "N/A") Uhr"
    }

}
