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
    
    private func setTableView() {
        tableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.identifier)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        view.addSubview(button)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func bind(reactor: MusicReactor) {
        reactor.state.map{$0.music}.bind(to: tableView.rx.items(cellIdentifier: MusicTableViewCell.identifier, cellType: MusicTableViewCell.self)) { index, item, cell in
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
