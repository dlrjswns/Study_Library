//
//  FloatingButton.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/07.
//

import UIKit

class FloatingButton: UIView {
    
    private let button: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        button.backgroundColor = .systemMint
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
