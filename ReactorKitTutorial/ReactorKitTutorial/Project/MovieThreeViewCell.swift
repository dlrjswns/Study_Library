//
//  MovieThreeViewCell.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/07.
//

import UIKit

class MovieThreeViewCell: UICollectionViewCell {
    
    static let identifier = "MovieThreeViewCell"
    
    private let movieTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func configureCell() {
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureCell(with model: Movie) {
        movieTitleLabel.text = model.title
    }
}
