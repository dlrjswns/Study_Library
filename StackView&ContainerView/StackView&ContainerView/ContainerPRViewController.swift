//
//  ContainerPRViewController.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/12/28.
//

import UIKit

class ContainerPRViewController: UIViewController {
    
    private let addButton: UIButton = {
       let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let removeButton: UIButton = {
       let button = UIButton()
        button.setTitle("삭제", for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        view.addSubview(removeButton)
        removeButton.translatesAutoresizingMaskIntoConstraints = false
        removeButton.centerYAnchor.constraint(equalTo: addButton.centerYAnchor).isActive = true
        removeButton.leftAnchor.constraint(equalTo: addButton.rightAnchor, constant: 30).isActive = true
        
        addButton.addTarget(self, action: #selector(didTappedAddButton), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(didTappedRemoveButton), for: .touchUpInside)
    }
    
    @objc func didTappedAddButton() {
        addViewController(AngViewController())
        addViewController(DngViewController())
    }
    
    @objc func didTappedRemoveButton() {
        removeViewController(AngViewController())
        removeViewController(DngViewController())
    }
    
    func addViewController(_ viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = CGRect(x: 300, y: 300, width: 300, height: 300)
        viewController.didMove(toParent: self)
    }
    
    func removeViewController(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil) // 제거되기 직전에 호출
        viewController.removeFromParent() // parentVC로 부터 관계 삭제
        viewController.view.removeFromSuperview() //
    }
}

class AngViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        print("안녕")
    }
}

class DngViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

