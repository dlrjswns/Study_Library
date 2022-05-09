//
//  BeerListCell.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import UIKit
import SnapKit

class BeerListCell: UITableViewCell {
    
    static let identifier = "BeerListCell"
    
    var currentBeer: Beer?
    
    private let beerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
//        imageView.image = UIImage(systemName: "heart.fill")
        return imageView
    }()
    
    private let beerIdLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let beerTagLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        beerImageView.image = nil
        beerNameLabel.text = nil
        beerTagLabel.text = nil
        beerIdLabel.text = nil
    }
    
    private func configureCell() {
        contentView.addSubview(beerImageView)
        contentView.addSubview(beerIdLabel)
        contentView.addSubview(beerNameLabel)
        contentView.addSubview(beerTagLabel)
        
        beerImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.height.equalTo(contentView.snp.height)
        }
        
        beerIdLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(contentView.frame.height / 4)
            make.left.equalTo(beerImageView.snp.right)
        }
        
        beerNameLabel.snp.makeConstraints { make in
            make.left.equalTo(beerImageView.snp.right)
//            make.centerY.equalTo(contentView.frame.height / 4)
            make.top.equalTo(beerIdLabel.snp.top).offset(contentView.frame.height / 4 * 2)
        }
        
        beerTagLabel.snp.makeConstraints { make in
            make.left.equalTo(beerImageView.snp.right)
            make.top.equalTo(beerNameLabel.snp.bottom).offset(contentView.frame.height / 4)
        }
    }
    
    public func configureCell(with model: Beer) {
        guard let name = model.name,
              let tagline = model.tagline else {
            return
        }
        currentBeer = model
        beerImageView.setImage(with: model.imageUrl)
        beerNameLabel.text = name
        beerTagLabel.text = tagline
        beerIdLabel.text = "\(model.id!)"
        self.accessoryType = .disclosureIndicator
    }
}
