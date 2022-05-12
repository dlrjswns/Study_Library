//
//  RandomSuccessView.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/12.
//

import UIKit
import Lottie
import SnapKit

class RandomSuccessView: UIView {
    
    private let successView: AnimationView = {
       let animationView = AnimationView(name: "congraturation")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.clipsToBounds = true
        animationView.play()
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(successView)
        successView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
