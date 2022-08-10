//
//  HomeTabCollectionViewCell.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/09.
//

import UIKit

class HomeTabCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeTabCollectionViewCell"
    
    private let tabLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
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
        
        tabLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tabLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        tabLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        tabLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func configureUI() {
        contentView.addSubview(tabLabel)
        tabLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: String) {
        tabLabel.text = model
    }
}
