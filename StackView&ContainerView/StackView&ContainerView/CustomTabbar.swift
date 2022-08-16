//
//  CustomTabbar.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/11.
//

import UIKit

protocol CustomTabbarDelegate: AnyObject {
    func didTappedCustomTabbar(_ indexPath: IndexPath)
}

class CustomTabbar: UIView {
    
    weak var delegate: CustomTabbarDelegate?
    
    private let customTabbarModel = ["전체", "프로젝트", "스터디", "두근"]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let bottomView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    var bottomViewWidthAnchor: NSLayoutConstraint!
    var bottomViewLeadingAnchor: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setCollectionViewResister(collectionView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        bottomViewLeadingAnchor = bottomView.leftAnchor.constraint(equalTo: leftAnchor)
        bottomViewWidthAnchor = bottomView.widthAnchor.constraint(equalToConstant: frame.width / 4)
        bottomViewLeadingAnchor.isActive = true
        bottomViewWidthAnchor.isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func setCollectionViewResister(_ collectionView: UICollectionView) {
        collectionView.register(CustomTabbarCollectionViewCell.self, forCellWithReuseIdentifier: CustomTabbarCollectionViewCell.identifier)
    }
    
    private func configureUI() {
        addSubview(collectionView)
        addSubview(bottomView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension CustomTabbar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customTabbarModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomTabbarCollectionViewCell.identifier, for: indexPath) as? CustomTabbarCollectionViewCell ?? CustomTabbarCollectionViewCell()
        cell.configureUI(with: customTabbarModel[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTappedCustomTabbar(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

class CustomTabbarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomTabbarCollectionViewCell"
    
    private let tabLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
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
    
    private func configureUI() {
        contentView.addSubview(tabLabel)
        tabLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureUI(with model: String) {
        tabLabel.text = model
    }
}


class A {
    func configure<T>(_ :T) {
        
    }
}
