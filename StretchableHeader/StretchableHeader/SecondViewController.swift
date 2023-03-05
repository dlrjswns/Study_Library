//
//  SecondViewController.swift
//  StretchableHeader
//
//  Created by 이건준 on 2023/02/23.
//

import UIKit

final class SecondViewController: UIViewController {
  
  private lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
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

    self.navigationController?.navigationBar.prefersLargeTitles = true
    self.navigationItem.rightBarButtonItems = [
      UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: nil),
      UIBarButtonItem(image: UIImage(systemName: "pencil.slash"), style: .plain, target: self, action: nil),
    ]
  }
}
extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
Optional({
     data =     {
         content =         (
                         {
                 commentCount = 0;
                 content = Test;
                 createdAt = "2023-02-23 07:43:39";
                 feedId = 36;
                 feedImage = "";
                 feedType = LINE;
                 isAuthor = 1;
                 isHost = 1;
                 likeCount = 0;
                 nickname = "\Uc0ac\Ub791\Ud574";
                 pin = 0;
                 plubbingId = 32;
                 profileImage = "<null>";
                 title = Hello;
                 viewType = NORMAL;
             }
         );
         last = 1;
         totalElements = 1;
         totalPages = 1;
     };
 })
Optional({
     data =     {
         content =         (
                         {
                 commentCount = 0;
                 content = Test;
                 createdAt = "2023-02-23 09:03:45";
                 feedId = 45;
                 feedImage = "";
                 feedType = LINE;
                 isAuthor = 1;
                 isHost = 1;
                 likeCount = 0;
                 nickname = "\Uc88b\Uc544\Ud574";
                 pin = 0;
                 plubbingId = 32;
                 profileImage = "<null>";
                 title = Hello;
                 viewType = NORMAL;
             }
         );
         last = 0;
         totalElements = 2;
         totalPages = 1;
     };
 })
