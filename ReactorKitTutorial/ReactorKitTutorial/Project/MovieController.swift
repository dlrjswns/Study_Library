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
    
    private lazy var movieSearchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "영화를 검색해주세요"
        return searchBar
    }()
    
    private var movieModel: [PopularMovie] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    private var searchMovieModel: [Movie] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    
    init(reactor: MovieReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewCompositionalLayout = UICollectionViewCompositionalLayout { [weak self] (section, env) -> NSCollectionLayoutSection? in
            if section == 0 {
                return self?.sectionOneLayout()
            } else if section == 1 {
                return self?.sectionTwoLayout()
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
        self.navigationItem.titleView = movieSearchBar
        
        var set = Set([1, 2, 3])
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
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieOneViewCell.self, forCellWithReuseIdentifier: MovieOneViewCell.identifier)
        collectionView.register(MovieTwoViewCell.self, forCellWithReuseIdentifier: MovieTwoViewCell.identifier)
        collectionView.register(MovieThreeViewCell.self, forCellWithReuseIdentifier: MovieThreeViewCell.identifier)
    }
    
    func bind(reactor: MovieReactor) {
        //Action
        Observable.just(MovieReactor.Action.viewDidLoad)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        movieSearchBar.rx.text.orEmpty.filter{ $0.count != 0 }.distinctUntilChanged().map{ Reactor.Action.searchMovie($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //State
        reactor.state.map{ $0.popularMovies }
            .subscribe(onNext: { [weak self] popularMovies in
                guard let popularMovies = popularMovies else { return }
                self?.movieModel = popularMovies
            }).disposed(by: disposeBag)
        
        reactor.state.map{ $0.searchMovies }
            .subscribe(onNext: { [weak self] searchMovies in
                guard let searchMovies = searchMovies else { return }
                self?.searchMovieModel = searchMovies
            }).disposed(by: disposeBag)
    }
}

extension MovieController {
    func sectionOneLayout() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1/5))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func sectionTwoLayout() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/3)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}

extension MovieController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return searchMovieModel.count
        } else {
            return movieModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieOneViewCell.identifier, for: indexPath) as? MovieOneViewCell ?? MovieOneViewCell()
            cell.configureUI(with: movieModel[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTwoViewCell.identifier, for: indexPath) as? MovieTwoViewCell ?? MovieTwoViewCell()
            cell.configureUI(with: movieModel[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieThreeViewCell.identifier, for: indexPath) as? MovieThreeViewCell ?? MovieThreeViewCell()
            cell.configureCell(with: searchMovieModel[indexPath.row])
            return cell
        }
        
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieOneViewCell.identifier, for: indexPath) as? MovieOneViewCell ?? MovieOneViewCell()
//            cell.configureUI(with: movieModel[indexPath.row])
//            return cell
//        } else if indexPath.section == 1 {
//            return UICollectionViewCell()
//        } else {
//            return UICollectionViewCell()
//        }
    }
}
