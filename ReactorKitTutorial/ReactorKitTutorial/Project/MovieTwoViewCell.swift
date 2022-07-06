//
//  MovieTwoViewCell.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/06.
//

import UIKit

class MovieTwoViewCell: UICollectionViewCell {
    
    static let identifier = "MovieTwoViewCell"
    
    private let movieImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let movieTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        
        movieTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        movieTitleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 20).isActive = true
    }
    
    private func configureUI() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: PopularMovie) {
        movieImageView.setImage(string: model.posterPath)
        movieTitleLabel.text = model.title
    }
}
