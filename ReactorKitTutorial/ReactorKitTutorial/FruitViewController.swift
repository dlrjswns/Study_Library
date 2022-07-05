//
//  FruitViewController.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/17.
//

import UIKit
import ReactorKit
import RxCocoa

class FruitViewController: UIViewController, View {
    
    private let reactor: FruitReactor
    
    init(reactor: FruitReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    private lazy var appleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("사과", for: .normal)
        return button
    }()
    
    private lazy var bananaButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("바나나", for: .normal)
        return button
    }()
    
    private lazy var grapeButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("포도", for: .normal)
        return button
    }()
    
    private lazy var selectedLabel: UILabel = {
       let label = UILabel()
        label.text = "선택되어진 과일 없음"
        return label
    }()
    
    private lazy var stack: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [
            appleButton, bananaButton, grapeButton, selectedLabel
       ])
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    // MARK: Binding Properties
    var disposeBag: DisposeBag = DisposeBag()
//    let fruitReactor = FruitReactor()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Configure
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: Helpers
    func bind(reactor: FruitReactor) {
        // Input
        appleButton.rx.tap.map { FruitReactor.Action.apple }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        bananaButton.rx.tap.map { FruitReactor.Action.banana }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        grapeButton.rx.tap.map { FruitReactor.Action.grapes }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // Output
        reactor.state.map{ $0.fruitName }
            .distinctUntilChanged()
            .map{ $0 }
            .subscribe(onNext: { val in
                self.selectedLabel.text = val
            })
            .disposed(by: disposeBag)
        
        reactor.state.map{ $0.isLoading }
            .distinctUntilChanged()
            .map{ $0 }
            .subscribe(onNext: { val in
                if val == true {
                    self.selectedLabel.text = "로딩중입니다"
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}
