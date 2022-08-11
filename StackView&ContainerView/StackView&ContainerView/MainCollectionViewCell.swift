//
//  MainCollectionViewCell.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/11.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    
    private let numberLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
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
        numberLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    private func configureUI() {
        contentView.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: String) {
        
    }
}
