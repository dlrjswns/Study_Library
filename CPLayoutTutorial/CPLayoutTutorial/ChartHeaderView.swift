//
//  ChartHeaderView.swift
//  CPLayoutTutorial
//
//  Created by 이건준 on 2022/06/21.
//

import UIKit

class ChartHeaderView: UICollectionReusableView {
    
    static let identifier = "ChartHeaderView"
    
    private let chartLabel: UILabel = {
       let label = UILabel()
        label.text = "Chart"
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 30, weight: .bold)
//        label.backgroundColor = .black
        return label
    }()
    
    private let moreButton: UIButton = {
       let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
//        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chartLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        chartLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        moreButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        chartLabel.text = nil
//        moreButton.setTitle(nil, for: .normal)
////        moreButton.setTitleColor(nil, for: .normal)
//    }
    
    private func configureUI() {
        addSubview(chartLabel)
        chartLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    public func configureUI() {
//        chartLabel.text = "Chart"
//        moreButton.setTitle("더보기", for: .normal)
//    }
}
