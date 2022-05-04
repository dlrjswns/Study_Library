//
//  MainTabbarController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import UIKit
import SnapKit

private class BeerCustomTabbar: UIView {
    private let beerListButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "beers"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let beerButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "beer"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let beerRandomButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "randomBeer"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .systemPink
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        beerListButton.snp.updateConstraints { make in
//            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self.snp.left).offset(self.frame.width / 5)
            make.width.equalTo(self.frame.width / 5)
        }
        
        beerButton.snp.updateConstraints { make in
            print("heith = \(self.frame.height)")
//            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(beerListButton.snp.right).offset(self.frame.width / 5)
            make.width.equalTo(self.frame.width / 5)
            make.height.equalTo(self.frame.height - 60)
        }
        
        beerRandomButton.snp.updateConstraints { make in
            make.centerY.top.bottom.equalToSuperview()
            make.width.equalTo(self.frame.width / 5)
            make.left.equalTo(beerButton.snp.right).offset(self.frame.width / 5)
        }
        
    }
    
    private func configureUI() {
        self.addSubview(beerListButton)
        self.addSubview(beerButton)
        self.addSubview(beerRandomButton)
        
        beerListButton.snp.makeConstraints { make in
            make.centerY.top.bottom.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(self.frame.width / 5)
            make.width.equalTo(self.frame.width / 5)
        }
        
        beerButton.snp.makeConstraints { make in
            make.centerY.top.bottom.equalToSuperview()
            make.left.equalTo(beerListButton.snp.right).offset(self.frame.width / 5)
            make.width.equalTo(self.frame.width / 5)
            make.height.equalTo(self.frame.height - 60)
        }
        
        beerRandomButton.snp.updateConstraints { make in
            make.centerY.top.bottom.equalToSuperview()
            make.left.equalTo(beerButton.snp.right).offset(self.frame.width / 5)
            make.width.equalTo(self.frame.width / 5)
        }
    }
}

class MainTabbarController: UITabBarController {
    
    fileprivate let beerTabbar = BeerCustomTabbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI() 
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        self.tabBar.isHidden = true
        
        view.addSubview(beerTabbar)
        beerTabbar.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
