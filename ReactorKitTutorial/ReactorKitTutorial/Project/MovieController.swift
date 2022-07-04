//
//  MovieController.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/07/04.
//

import UIKit
import ReactorKit

class MovieController: UIViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let reactor: MovieReactor
    
    private var movieModel: [PopularMovie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(reactor: MovieReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] (section, env) -> NSCollectionLayoutSection? in
            if section == 0 {
                return self?.sectionOneLayout()
            } else if section == 1 {
                return self?.sectionOneLayout()
            } else {
                return self?.sectionOneLayout()
            }
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setCollectionView(collectionView)
        bind(reactor: reactor)
    }
    
    private func configureUI() {
        
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func bind(reactor: MovieReactor) {
        reactor.initialState.popularMovies.map { [weak self] popularMovies in
            self?.movieModel = popularMovies
        }
    }
}

extension MovieController {
    func sectionOneLayout() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/5)
            ),
            subitems: [item]
        )
        return NSCollectionLayoutSection(group: group)
    }
}

extension MovieController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
