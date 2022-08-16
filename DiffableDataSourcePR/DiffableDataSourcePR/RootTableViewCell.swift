//
//  RootTableViewCell.swift
//  DiffableDataSourcePR
//
//  Created by 이건준 on 2022/08/16.
//

import UIKit

class RootTableViewCell: UITableViewCell {
    
    static let identifier = "RootTableViewCell"
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let userImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        userNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        userNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
//        userNameLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor).isActive = true
    }
    
    public func configureUI(with model: String) {
        userNameLabel.text = model
    }
}
