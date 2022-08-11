//
//  TabPracticeVC.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/11.
//

import UIKit

class TabPracticeVC: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let customTabbar = CustomTabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCollectionViewRegister(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        customTabbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        customTabbar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        customTabbar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        customTabbar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: customTabbar.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setCollectionViewRegister(_ collectionView: UICollectionView) {
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        view.addSubview(customTabbar)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        customTabbar.translatesAutoresizingMaskIntoConstraints = false
        customTabbar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension TabPracticeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell ?? MainCollectionViewCell()
        cell.configureUI(with: "\(indexPath.row + 1) 번째 화면")
        return cell
    }
}

extension TabPracticeVC: CustomTabbarDelegate {
    func didTappedCustomTabbar(_ indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
