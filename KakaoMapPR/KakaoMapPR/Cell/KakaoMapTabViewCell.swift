//
//  KakaoMapTabViewCell.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import UIKit

protocol KakaoMapTabViewCelldelegate: AnyObject {
    func didTappdCell()
}

struct MapLocation {
    let latitude: Double
    let longitude: Double
}

class KakaoMapTabViewCell: UICollectionViewCell {
    
    static let identifier = "KakaoMapTabViewCell"
    
    weak var delegate: KakaoMapTabViewCelldelegate?
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private let label: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.backgroundColor = .systemYellow
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let highlightView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .black
        vw.isHidden = true
        return vw
    }()
    
    override var isSelected: Bool {
        didSet {
            label.textColor = isSelected ? .black : .white
            highlightView.isHidden = isSelected ? false : true
            delegate?.didTappdCell()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(highlightView)
        highlightView.translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 20
        layer.borderColor = UIColor.systemYellow.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        highlightView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        highlightView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        highlightView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        highlightView.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model: String) {
        label.text = model
    }
}
