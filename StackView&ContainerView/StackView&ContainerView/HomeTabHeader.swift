//
//  HomeTabHeader.swift
//  StackView&ContainerView
//
//  Created by 이건준 on 2022/08/10.
//

import UIKit

protocol HomeTabHeaderDelegate: AnyObject {
    
}

class HomeTabHeader: UICollectionReusableView {
    
    static let identifier = "HomeTabHeader"
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [entireButton, projectButton, studyButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let entireButton: UIButton = {
       let button = UIButton()
        button.setTitle("전체", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 0
        return button
    }()
    
    private let projectButton: UIButton = {
        let button = UIButton()
         button.setTitle("프로젝트", for: .normal)
        button.setTitleColor(.label, for: .normal)
         button.titleLabel?.textAlignment = .center
        button.tag = 1
         return button
    }()
    
    private let studyButton: UIButton = {
        let button = UIButton()
         button.setTitle("스터디", for: .normal)
        button.setTitleColor(.label, for: .normal)
         button.titleLabel?.textAlignment = .center
        button.tag = 2
         return button
    }()
    
    private let bottomLineView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .systemPink
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        bottomLineView.leftAnchor.constraint(equalTo: entireButton.leftAnchor).isActive = true
        bottomLineView.rightAnchor.constraint(equalTo: entireButton.rightAnchor).isActive = true
        bottomLineView.bottomAnchor.constraint(equalTo: entireButton.bottomAnchor).isActive = true
        bottomLineView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        addSubview(stackView)
        addSubview(bottomLineView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        
        _ = [entireButton, projectButton, studyButton].map{ setActionButton($0) }
    }
    
    private func setActionButton(_ button: UIButton) {
        button.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
    }
    
    @objc func didTappedButton(_ sender: UIButton) {
//        guard let tag = sender.tag else { return }
        if sender.tag == 0 {
            print("tag 0")
            UIView.animate(withDuration: 2.0) { [weak self] in
                guard let `self` = self else { return }
                self.bottomLineView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor).isActive = true
                self.layoutIfNeeded()
            }
        } else if sender.tag == 1 {
            print("tag 1")
            UIView.animate(withDuration: 2.0) { [weak self] in
                guard let `self` = self else { return }
                self.bottomLineView.centerXAnchor.constraint(equalTo: self.stackView.centerXAnchor).isActive = true
                self.layoutIfNeeded()
            }
        } else { // tag == 2
            print("tag 2")
            UIView.animate(withDuration: 2.0) { [weak self] in
                guard let `self` = self else { return }
                self.bottomLineView.leftAnchor.constraint(equalTo: self.stackView.leftAnchor).isActive = true
                self.layoutIfNeeded()
            }
        }
    }
}
