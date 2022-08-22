//
//  rx + extension.swift
//  RxDelegateProxyPR
//
//  Created by 이건준 on 2022/08/22.
//

import RxSwift
import UIKit
import RxCocoa

extension Reactive where Base: UITextField {
    var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: self.base)
    }
    
    var shouldChangeCharactersIn: Observable<Bool> {
        return delegate.methodInvoked(#selector(UITextFieldDelegate.textField(_:shouldChangeCharactersIn:replacementString:))).map { parameters in
            return parameters[1] as? Bool ?? false
        }
    }
    
    var anonymousText: Observable<String> {
        return delegate.methodInvoked(#selector(UITextFieldDelegate.textFieldDidBeginEditing(_:))).map { parameters in
            return parameters as? String ?? ""
        }
    }
}

class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {
    static func registerKnownImplementations() {
        self.register { textField -> RxTextFieldDelegateProxy in
            return RxTextFieldDelegateProxy(parentObject: textField, delegateProxy: self)
        }
    }
    
    static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }
    
    
}

