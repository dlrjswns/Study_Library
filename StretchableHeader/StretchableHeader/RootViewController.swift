//
//  RootViewController.swift
//  StretchableHeader
//
//  Created by 이건준 on 2023/02/23.
//

import UIKit

final class RootViewController: UIViewController {
  
  private let layout: StretchableUICollectionViewFlowLayout = {
    let layout = StretchableUICollectionViewFlowLayout()
    layout.headerReferenceSize = CGSize(width: .zero, height: 100)
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(RootCollectionViewCell.self, forCellWithReuseIdentifier: RootCollectionViewCell.identifier)
    collectionView.register(RootCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RootCollectionHeaderView.identifier)
    return collectionView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
    collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RootCollectionViewCell.identifier, for: indexPath) as? RootCollectionViewCell ?? RootCollectionViewCell()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RootCollectionHeaderView.identifier, for: indexPath) as? RootCollectionHeaderView ?? RootCollectionHeaderView()
    return headerView
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = SecondViewController()
    vc.navigationItem.largeTitleDisplayMode = .always
    vc.title = "요란한 한줄"
    self.navigationController?.pushViewController(vc, animated: true)
  }
}

final class RootCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "RootCollectionViewCell"
  
  private let label: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .semibold)
    label.textColor = .black
    label.text = "라벨"
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    contentView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
    label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }
}

final class StretchableUICollectionViewFlowLayout: UICollectionViewFlowLayout {
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    guard let offset = collectionView?.contentOffset, let stLayoutAttributes = layoutAttributes else {
      return layoutAttributes
    }
    
    if offset.y < 0 {
      for attributes in stLayoutAttributes where attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
        let diffValue = abs(offset.y)
        var frame = attributes.frame
        frame.size.height = max(0, headerReferenceSize.height + diffValue)
        frame.origin.y = frame.minY - diffValue
        attributes.frame = frame
      }
    }
    return layoutAttributes
  }
}

final class RootCollectionHeaderView: UICollectionReusableView {
  
  static let identifier = "RootCollectionHeaderView"
  
  private let label: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 15, weight: .semibold)
    label.textColor = .black
    label.text = "라벨"
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.topAnchor.constraint(equalTo: topAnchor).isActive = true
    label.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    label.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
}
