//
//  KakaoMapTabViewCell.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import UIKit

class KakaoMapTabViewCell: UICollectionViewCell {
    
    static let identifier = "KakaoMapTabViewCell"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.backgroundColor = .systemYellow
        label.textColor = .white
        label.text = "내 집"
        label.textAlignment = .center
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .black : .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
