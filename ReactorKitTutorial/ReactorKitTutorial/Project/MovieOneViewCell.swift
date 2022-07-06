//
//  MovieOneViewCell.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/06.
//

import UIKit

class MovieOneViewCell: UICollectionViewCell {
    
    static let identifier = "MovieOneViewCell"
    
    private let movieTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "영화가 존재하지않습니다"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let movieVoteAverageLabel: UILabel = {
       let label = UILabel()
        label.text = "평점이 존재하지않습니다"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let movieVoteCountLabel: UILabel = {
       let label = UILabel()
        label.text = "평점 수가 존재하지않습니다"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitleLabel.text = nil
        movieVoteAverageLabel.text = nil
        movieVoteCountLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        movieTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        movieVoteAverageLabel.leftAnchor.constraint(equalTo: movieTitleLabel.rightAnchor, constant: 20).isActive = true
        movieVoteAverageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height / 4).isActive = true
        
        movieVoteCountLabel.leftAnchor.constraint(equalTo: movieTitleLabel.rightAnchor, constant: 20).isActive = true
        movieVoteCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -contentView.frame.height / 4).isActive = true
    }
    
    private func configureUI() {
        contentView.addSubview(movieTitleLabel)
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieVoteAverageLabel)
        movieVoteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieVoteCountLabel)
        movieVoteCountLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: PopularMovie) {
        movieTitleLabel.text = model.title
        movieVoteAverageLabel.text = "\(model.voteAverage)"
        movieVoteCountLabel.text = "\(model.voteCount)"
    }
}
