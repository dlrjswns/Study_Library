//
//  ContainerViewController.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/09.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private let tabModel = ["전체", "프로젝트", "스터디"]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sec, env -> NSCollectionLayoutSection? in
        guard let `self` = self else { return nil }
            return self.setSectionZeroLayout()
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let bottomLineView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    private let customTabbar = CustomTabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureUI()
        setCollectionViewRegister(collectionView)
        
        let firstVC = FirstVC()
        let secondVC = SecondVC()
        addChild(firstVC)
        addChild(secondVC)
        view.addSubview(firstVC.view)
        view.addSubview(secondVC.view)
        firstVC.view.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        secondVC.view.frame = CGRect(x: 200, y: 200, width: 50, height: 50)
        firstVC.didMove(toParent: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        view.addSubview(bottomLineView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setCollectionViewRegister(_ collectionView: UICollectionView) {
        collectionView.register(HomeTabCollectionViewCell.self, forCellWithReuseIdentifier: HomeTabCollectionViewCell.identifier)
        collectionView.register(HomeTabHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeTabHeader.identifier)
    }
}

extension ContainerViewController {
    fileprivate func setSectionZeroLayout() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(3/4),
                heightDimension: .absolute(50)
            ),
            subitem: item,
            count: 3
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(100)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
//        section.boundarySupplementaryItems = [header]
        return section
    }
    
    fileprivate func setSectionOneLayout() -> NSCollectionLayoutSection? {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(1),
                heightDimension: .absolute(1)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(1),
                heightDimension: .absolute(1)
            ),
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }
}

extension ContainerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return tabModel.count
        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTabCollectionViewCell.identifier, for: indexPath) as? HomeTabCollectionViewCell ?? HomeTabCollectionViewCell()
        cell.configureUI(with: tabModel[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HomeTabHeader.identifier, for: indexPath) as? HomeTabHeader ?? HomeTabHeader()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeTabCollectionViewCell else { return }
        let rowNum = indexPath.row
        
        if rowNum == 0 {
            
        } else if rowNum == 1 {
            
        } else {
            
        }
//        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeTabCollectionViewCell else { return }
//        UIView.animate(withDuration: 2.0) { [weak self] in
//            guard let `self` = self else { return }
//            self.bottomLineView.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
//            self.bottomLineView.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
//            self.bottomLineView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
//            self.bottomLineView.heightAnchor.constraint(equalToConstant: 20).isActive = true
//            self.view.layoutIfNeeded()
//        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
}

extension ContainerViewController: HomeTabCollectionViewCellDelegate {
    func didTappedHomeTabCollectionViewCell() {
        print("tapped")
    }
}
