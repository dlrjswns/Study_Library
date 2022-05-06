//
//  EmptyView.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/06.
//

import UIKit
import Lottie
import SnapKit

class EmptyView: UIView {
    
    private let emptyView: AnimationView = {
        let vw = AnimationView(name: "emptyScreen")
        vw.contentMode = .scaleAspectFit
        vw.loopMode = .loop
        vw.play()
        return vw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
