//
//  RootViewController.swift
//  NotificationRxPR
//
//  Created by 이건준 on 2022/05/08.
//

import UIKit
import RxSwift
import RxCocoa

extension Notification.Name {
    static let myPractice = Notification.Name(rawValue: "MyPratice")
}

class RootViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(UIColor.systemMint, for: .normal)
        button.backgroundColor = .red
        button.tintColor = UIColor.red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(didTappdButton), for: .touchUpInside)
        NotificationCenter.default.rx.notification(.myPractice).subscribe(onNext: { notification in
            print("notification= \(notification)")
        }).disposed(by: disposeBag)
        
//        NotificationCenter.default.rx.notification(UIApplication., object: <#T##AnyObject?#>)
    }
    
    @objc private func didTappdButton() {
        NotificationCenter.default.post(name: .myPractice, object: nil)
    }
}
