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
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let beerIdLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let beerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let beerNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let beerTagLineLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        return label
    }()
    
    private let beerDescriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = .max
        label.font = .systemFont(ofSize: 20, weight: .thin)
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
//        createMockData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        beerImageView.snp.updateConstraints { make in
            make.width.height.equalTo(view.frame.width - 80)
        }
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(beerIdLabel)
        scrollView.addSubview(beerImageView)
        scrollView.addSubview(beerNameLabel)
        scrollView.addSubview(beerTagLineLabel)
        scrollView.addSubview(beerDescriptionLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        beerIdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        beerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerIdLabel.snp.bottom).offset(10)
            make.width.height.equalTo(view.frame.width - 80)
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
            make.bottom.equalToSuperview().offset(-80)
            make.left.right.equalToSuperview().inset(20)
        }
        
        beerIdLabel.text = "\(selectedBeer.id!)"
        beerImageView.setImage(with: selectedBeer.imageUrl)
        beerNameLabel.text = selectedBeer.name
        beerDescriptionLabel.text = selectedBeer.description
        beerTagLineLabel.text = selectedBeer.tagline
    }
    
}
