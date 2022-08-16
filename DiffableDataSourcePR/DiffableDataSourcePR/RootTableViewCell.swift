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
        
    }
    
    public func configureUI(with model: String) {
        userNameLabel.text = model
    }
}
