//
//  BeerDetailViewController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/09.
//

import UIKit
import SnapKit

class BeerDetailViewController: UIViewController {
    
    private let selectedBeer: Beer
    
    private let beerIdLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerImageView: UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    
    private let beerNameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerTagLineLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerDescriptionLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    struct Dependency {
        let selectedBeer: Beer
    }
    
    init(dependency: Dependency) {
        selectedBeer = dependency.selectedBeer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    public func configureUI(with model: Beer) {
        print("BeerDetailVC - model = \(model)")
    }
    
    private func configureUI() {
        view.addSubview(beerIdLabel)
        view.addSubview(beerImageView)
        view.addSubview(beerNameLabel)
        view.addSubview(beerTagLineLabel)
        view.addSubview(beerDescriptionLabel)
        
        beerIdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        beerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerIdLabel.snp.bottom).offset(10)
        }
        
        beerNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerImageView.snp.bottom).offset(10)
        }
        
        beerTagLineLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerNameLabel.snp.bottom).offset(10)
        }
        
        beerDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerTagLineLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
