//
//  FoodCell.swift
//  Project1
//
//  Created by 이건준 on 2022/04/29.
//

import UIKit

class FoodCell: UITableViewCell {
    
    static let identifier = "FoodCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        
    }
}
