//
//  RxSwiftViewController.swift
//  Project1
//
//  Created by 이건준 on 2022/05/01.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private let idTextField: UITextField = {
       let txt = UITextField()
        txt.placeholder = "아이디를 입력해주세요"
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.clipsToBounds = true
        txt.widthAnchor.constraint(equalToConstant: 270).isActive = true
        return txt
    }()
    
    private let pwTextField: UITextField = {
       let txt = UITextField()
        txt.placeholder = "비밀번호를 입력해주세요"
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layer.cornerRadius = 10
        txt.autocorrectionType = .no
        txt.autocapitalizationType = .none
        txt.clipsToBounds = true
        txt.widthAnchor.constraint(equalToConstant: 270).isActive = true
        return txt
    }()
    
    private let loginButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemPink
        btn.layer.cornerRadius = 10
        btn.clipsToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 270).isActive = true
        return btn
    }()
    
    private let idValidView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .red
        vw.layer.cornerRadius = 10
        vw.clipsToBounds = true
        vw.widthAnchor.constraint(equalToConstant: 10).isActive = true
        vw.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return vw
    }()
    
    private let pwValidView: UIView = {
       let vw = UIView()
        vw.backgroundColor = .red
        vw.layer.cornerRadius = 10
        vw.clipsToBounds = true
        vw.widthAnchor.constraint(equalToConstant: 10).isActive = true
        vw.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
        idTextField.rx.text.orEmpty.map(isValidID(id:))
            .subscribe(onNext: { [weak self] isValid in
                self?.idValidView.isHidden = isValid
                self?.loginButton.isEnabled = isValid
            }).disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty.map(isValidPW(pw:))
            .subscribe(onNext: { [weak self] isValid in
                self?.pwValidView.isHidden = isValid
                self?.loginButton.isEnabled = isValid
            }).disposed(by: disposeBag)
        
        loginButton.addTarget(self, action: #selector(didTappedLoginButton), for: .touchUpInside)
        loginButton.rx.tap.subscribe(onNext: { tap in
            print("dfdsf")
        }).disposed(by: disposeBag)
    }
    
    @objc private func didTappedLoginButton() {
//        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "로그인 성공",
                                      message: nil,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .default))
        self.present(alert, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(idTextField)
        idTextField.translatesAutoresizingMaskIntoConstraints = false
        idTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        idTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        view.addSubview(pwTextField)
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        pwTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pwTextField.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 10).isActive = true
        
        idTextField.addSubview(idValidView)
        idValidView.translatesAutoresizingMaskIntoConstraints = false
        idValidView.rightAnchor.constraint(equalTo: idTextField.rightAnchor, constant: -5).isActive = true
        idValidView.topAnchor.constraint(equalTo: idTextField.topAnchor, constant: 5).isActive = true
        
        pwTextField.addSubview(pwValidView)
        pwValidView.translatesAutoresizingMaskIntoConstraints = false
        pwValidView.rightAnchor.constraint(equalTo: pwTextField.rightAnchor, constant: -5).isActive = true
        pwValidView.topAnchor.constraint(equalTo: pwTextField.topAnchor, constant: 5).isActive = true
        
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: pwTextField.bottomAnchor, constant: 10).isActive = true
        
    }
    
    private func isValidID(id: String) -> Bool {
        return id.count > 0
    }
    
    private func isValidPW(pw: String) -> Bool {
        return pw.count > 8
    }
}
