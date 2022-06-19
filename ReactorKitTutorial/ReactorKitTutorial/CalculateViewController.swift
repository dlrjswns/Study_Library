//
//  CalculateViewController.swift
//  ReactorKitTutorial
//
//  Created by 이건준 on 2022/06/18.
//

import UIKit
import ReactorKit
import RxCocoa

class CalculateViewController: UIViewController {
    
    private let reactor: CalculateReactor
    private var disposeBag = DisposeBag()
    
    init(reactor: CalculateReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    private let resultLabel: UILabel = {
       let label = UILabel()
        label.text = "0"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        minusButton.centerYAnchor.constraint(equalTo: resultLabel.centerYAnchor).isActive = true
        minusButton.rightAnchor.constraint(equalTo: resultLabel.leftAnchor, constant: -20).isActive = true
        
        plusButton.centerYAnchor.constraint(equalTo: resultLabel.centerYAnchor).isActive = true
        plusButton.leftAnchor.constraint(equalTo: resultLabel.rightAnchor, constant: 20).isActive = true
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(minusButton)
        view.addSubview(resultLabel)
        view.addSubview(plusButton)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func bind() {
        //Input
        minusButton.rx.tap.map{ CalculateReactor.Action.minusButtonClicked }
            .bind(to: reactor.action) // mutate()
            .disposed(by: disposeBag)
        
        plusButton.rx.tap.map{ CalculateReactor.Action.plusButtonClicked }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        //Ouput
        reactor.state
            .subscribe(onNext: { [weak self] state in
                self?.resultLabel.text = "\(state.resultNum)"
            })
            .disposed(by: disposeBag)
    }
}
