//
//  LoadingView.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/06.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    
    private let loadingView: UIActivityIndicatorView = {
        let vw = UIActivityIndicatorView(style: .large)
        vw.hidesWhenStopped = true
        vw.startAnimating()
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
