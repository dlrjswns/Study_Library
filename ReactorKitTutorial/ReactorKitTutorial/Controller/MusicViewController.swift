//
//  MusicViewController.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/23.
//

import UIKit
import ReactorKit

class MusicViewController: UIViewController, View {
    var disposeBag: DisposeBag = DisposeBag()
    
    private let reactor: MusicReactor
    
    init(reactor: MusicReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reactor.action.map{_ in MusicReactor.Action.viewWillAppear}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let re = MusicRepositoryImpl()
        print("md = \(re.fetchData())")
        bind(reactor: reactor)
    }
    
    private func configureUI() {
        
    }
    
    func bind(reactor: MusicReactor) {
        reactor.state.subscribe(onNext: { state in
            print("state = \(state)")
        })
        .disposed(by: disposeBag)
    }
}
