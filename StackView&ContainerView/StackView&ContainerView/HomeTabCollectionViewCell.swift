//
//  HomeTabCollectionViewCell.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/09.
//

import UIKit

protocol HomeTabCollectionViewCellDelegate: AnyObject {
    func didTappedHomeTabCollectionViewCell()
}

class HomeTabCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeTabCollectionViewCell"
    
    weak var delegate: HomeTabCollectionViewCellDelegate?
    
    private let tabLabel: UILabel = {
      let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
//        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
//        addGestureRecognizerWithLabel(tabLabel)
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
    
    private func addGestureRecognizerWithLabel(_ label: UILabel) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTappedLabel))
        label.addGestureRecognizer(tap)
    }
    
    @objc func didTappedLabel() {
        delegate?.didTappedHomeTabCollectionViewCell()
    }
    
    private func configureUI() {
        contentView.addSubview(tabLabel)
        tabLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: String) {
        tabLabel.text = model
    }
}
