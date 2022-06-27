//
//  MusicViewController.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/23.
//

import UIKit
import RxCocoa
import ReactorKit

class MusicViewController: UIViewController, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    private let reactor: MusicReactor
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout{ section, env -> NSCollectionLayoutSection? in
            switch section {
                case 0:
                    return MusicViewController.sectionOneLayout()
                case 1:
                    return MusicViewController.sectionTwoLayout()
                default:
                    return MusicViewController.sectionThreeLayout()
            }
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.systemPink.cgColor
        return collectionView
    }()
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    
    private let button: UIButton  = {
        let button = UIButton()
        button.setTitle("클릭", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    init(reactor: MusicReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Observable.just(MusicReactor.Action.viewWillAppear).bind(to: reactor.action).disposed(by: disposeBag)
//        reactor.action.map{_ in MusicReactor.Action.viewWillAppear}
//            .bind(to: reactor.action)
//            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let re = MusicRepositoryImpl()
//        print("md = \(re.fetchData())")
        bind(reactor: reactor)
        configureUI()
        setTableView()
    }
    
    static func sectionOneLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalHeight(1/4)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/3)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    static func sectionTwoLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/4)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/3)), subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    static func sectionThreeLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/4)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/3)), subitems: [item])
        return NSCollectionLayoutSection(group: group)
    }
    
    private func setTableView() {
        collectionView.register(MusicCollectionViewCell.self,
                                forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
//        collectionView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        view.addSubview(button)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func bind(reactor: MusicReactor) {
        reactor.state.map{$0.music}.bind(to: collectionView.rx.items(cellIdentifier: MusicCollectionViewCell.identifier, cellType: MusicCollectionViewCell.self)) { index, item, cell in
            print("item = \(item)")
            cell.configureUI(with: item)
        }.disposed(by: disposeBag)
        Observable.just(MusicReactor.Action.viewWillAppear).bind(to: reactor.action).disposed(by: disposeBag)
        
        button.rx.tap.map{MusicReactor.Action.viewWillAppear}.bind(to: reactor.action).disposed(by: disposeBag)
        
        reactor.state.subscribe(onNext: { state in
            print("state = \(state)")
        })
        .disposed(by: disposeBag)
    }
}
//extension MusicViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 3
//    }
//}
