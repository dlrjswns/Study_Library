//
//  MusicCollectionViewCell.swift
//  CPLayoutTutorial
//
//  Created by 이건준 on 2022/06/22.
//

import UIKit

class MusicCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MusicCollectionViewCell"
    
    private let thumbnailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
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
        thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height / 2).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height / 2).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func configureUI() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: String) {
        thumbnailImageView.image = UIImage(systemName: model)
        titleLabel.text = model
        descriptionLabel.text = model
    }
}
