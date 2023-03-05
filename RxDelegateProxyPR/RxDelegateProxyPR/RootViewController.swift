//
//  RootViewController.swift
//  RxDelegateProxyPR
//
//  Created by 이건준 on 2022/08/22.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private let textField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "글자를 입력해주세요"
        return textField
    }()
    
    private let textView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .systemPink
        textView.contentInsetAdjustmentBehavior = .always
        textView.text = """
                                dsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsaddfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsadfsadfsadfasfdsafsadfsafsadfsadfdsfsdafsadfsafdsdfsdfasdfasfsa
        """
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
      
      Observable.from([true, true, true, true, true, true, true])
        .distinctUntilChanged { lhs, rhs in
          if lhs && rhs {
            print("lhs = \(lhs)")
            print("rhs = \(rhs)")
            return false
          }
          return true
        }
        .subscribe(onNext: { booi in
        print("booi = \(booi)")
        })
        .disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
//        textField.delegate = self
//        textField.rx.shouldChangeCharactersIn.asObservable().subscribe(onNext: { isChange in
//            print("dsfsadf = \(isChange)")
//        }).disposed(by: disposeBag)
////
//        textField.rx.anonymousText.subscribe(onNext: { text in
//            print("text = \(text)")
//        }).disposed(by: disposeBag)
    }
}

extension RootViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count == 3 {
            return false
        }
        return true
    }
    
    private func textFieldDidBeginEditing(_ textField: UITextField) -> String? {
        return textField.text
    }
}
