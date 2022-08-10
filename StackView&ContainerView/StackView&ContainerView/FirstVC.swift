//
//  FirstVC.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/10.
//

import UIKit

class FirstVC: UIViewController {
    
    private let subView1: UIView = {
       let vw = UIView()
        vw.backgroundColor = .systemRed
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let vw = SubView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vw)
        vw.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("FirstVC viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("FirstVC viewDidLayoutSubviews")
    }
}

class SubView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("SubViwe layoutSubviews")
    }
}

class SecondVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}
