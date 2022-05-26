//
//  KakaoMapInforTableViewCell.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/24.
//

import UIKit

class KakaoMapInforTableViewCell: UITableViewCell {
    
    static let identifier = "KakaoMapInforTableViewCell"
    
    var currentMapLocation: KakaoMapLocation?
    
    private let placeNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let roadAddressLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    override var isSelected: Bool {
        didSet {
            print("ttttt")
            if isSelected == true {
                if let currentMapLocation = currentMapLocation {
                    delegate?.didTappdCell(kakaoMapLocation: currentMapLocation)
                }
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeNameLabel.text = nil
        roadAddressLabel.text = nil
        accessoryType = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        placeNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height / 5).isActive = true
        
        roadAddressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        roadAddressLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor, constant: contentView.frame.height / 5).isActive = true
        
    }
    
    private func configureCell() {
        contentView.addSubview(placeNameLabel)
        contentView.addSubview(roadAddressLabel)
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        roadAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    public func configureCell(with model: KakaoMapLocation) {
        self.currentMapLocation = model
        placeNameLabel.text = model.placeName
        roadAddressLabel.text = model.roadAddressName
        accessoryType = .disclosureIndicator
    }
}
