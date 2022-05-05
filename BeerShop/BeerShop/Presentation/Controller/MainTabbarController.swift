//
//  MainTabbarController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import UIKit
import SnapKit

//enum BeerButtonType: Int {
//    case beer = 0
//    case beers = 1
//    case randomBeer = 2
//}

private class BeerCustomTabbar: UIView {
    let beerListButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "beers"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.tag = 0
        return button
    }()
    
    let beerButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "beer"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.tag = 1
        return button
    }()
    
    let beerRandomButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "randomBeer"), for: .normal)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.tag = 2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        backgroundColor = .systemPink
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        beerListButton.snp.updateConstraints { make in
            make.left.equalTo(self.snp.left).offset((self.frame.width - (self.frame.width / 5 * 3)) / 3)
            make.width.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
            make.height.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
        }
        beerListButton.layer.cornerRadius = ((self.frame.width - (self.frame.width / 5 * 3)) / 3) / 2
        
        beerButton.snp.updateConstraints { make in
            make.left.equalTo(beerListButton.snp.right).offset((self.frame.width - (self.frame.width / 5 * 3)) / 3)
            make.width.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
            make.height.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
        }
        beerButton.layer.cornerRadius = ((self.frame.width - (self.frame.width / 5 * 3)) / 3) / 2
        
        beerRandomButton.snp.updateConstraints { make in
            make.width.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
            make.height.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
            make.left.equalTo(beerButton.snp.right).offset((self.frame.width - (self.frame.width / 5 * 3)) / 3)
        }
        beerRandomButton.layer.cornerRadius = ((self.frame.width - (self.frame.width / 5 * 3)) / 3) / 2
    }
    
    private func configureUI() {
        self.addSubview(beerListButton)
        self.addSubview(beerButton)
        self.addSubview(beerRandomButton)
        
        beerListButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.snp.left).offset(self.frame.width - (self.frame.width / 5 * 3) / 5)
            make.width.equalTo(self.frame.width - (self.frame.width / 5 * 3) / 5)
            make.height.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
        }
        
        beerButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(beerListButton.snp.right).offset(self.frame.width - (self.frame.width / 5 * 3) / 5)
            make.width.equalTo(self.frame.width - (self.frame.width / 5 * 3) / 5)
            make.height.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
        }
        
        beerRandomButton.snp.updateConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(beerButton.snp.right).offset(self.frame.width - (self.frame.width / 5 * 3) / 5)
            make.width.equalTo(self.frame.width - (self.frame.width / 5 * 3) / 5)
            make.height.equalTo((self.frame.width - (self.frame.width / 5 * 3)) / 3)
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
            make.height.equalTo(60)
        }
        
        beerTabbar.beerListButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        beerTabbar.beerButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        beerTabbar.beerRandomButton.addTarget(self, action: #selector(didTappedButton), for: .touchUpInside)
        
    }
    
    @objc private func didTappedButton(_ sender: UIButton) {
        
        switch sender.tag {
            case BeerType.beer.rawValue: // 1
                beerTabbar.beerListButton.isSelected = false
                beerTabbar.beerButton.isSelected = true
                beerTabbar.beerRandomButton.isSelected = false
                selectedIndex = 0
            case BeerType.beers.rawValue: // 0
                beerTabbar.beerListButton.isSelected = true
                beerTabbar.beerButton.isSelected = false
                beerTabbar.beerRandomButton.isSelected = false
                selectedIndex = 1
            case BeerType.randomBeer.rawValue: // 2
                beerTabbar.beerListButton.isSelected = false
                beerTabbar.beerButton.isSelected = false
                beerTabbar.beerRandomButton.isSelected = true
            default:
                print("didTappeButton called - Button의 tag번호를 확인해주세요")
        }
    }
}
