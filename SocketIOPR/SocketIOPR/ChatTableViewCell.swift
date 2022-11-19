//
//  ChatTableViewCell.swift
//  SocketIOPR
//
//  Created by 이건준 on 2022/11/19.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    static let identifier = "ChatTableViewCell"
    
    private let chatLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(chatLabel)
        chatLabel.translatesAutoresizingMaskIntoConstraints = false
        chatLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        chatLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        chatLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
