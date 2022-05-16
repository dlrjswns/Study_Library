//
//  NoNetworkView.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/16.
//

import UIKit

class NoNetworkView: UIView {
    
    private let noNetworkLabel: UILabel = {
       let label = UILabel()
        label.text = "Please check your network"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let noNetworkImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "network")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(noNetworkLabel)
        addSubview(noNetworkImageView)
        noNetworkLabel.translatesAutoresizingMaskIntoConstraints = false
        noNetworkImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        noNetworkImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noNetworkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        noNetworkImageView.widthAnchor.constraint(equalToConstant: self.frame.width / 3).isActive = true
        noNetworkImageView.heightAnchor.constraint(equalToConstant: self.frame.width / 3).isActive = true
        
        noNetworkLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        noNetworkLabel.topAnchor.constraint(equalTo: noNetworkImageView.bottomAnchor, constant: 10).isActive = true
        
        
    }
}
