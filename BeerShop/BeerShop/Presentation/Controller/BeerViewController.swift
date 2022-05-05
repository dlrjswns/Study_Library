//
//  BeerViewController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/05.
//

import UIKit
import RxSwift
import RxCocoa

class BeerViewController: UIViewController {
    
    private let viewModel: BeerViewModelType
    var disposeBag = DisposeBag()
    
    init(viewModel: BeerViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.placeholder = "아이디로 검색"
        return searchBar
    }()
    
    private let beerIdLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerNameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let beerTagLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let beerDescriptionLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        title = "Search Beer"
//        navigationController?.navigationItem.titleView = searchBar
        navigationItem.titleView = searchBar
    }
    
    private func bind() {
        searchBar.rx.text.orEmpty.bind(to: viewModel.searchIdInput)
            .disposed(by: disposeBag)
        
        viewModel.beerErrorOutput.emit(onNext: { beerError in
            print("BeerErrorOutput occured = \(beerError.errorMessage)")
        }).disposed(by: disposeBag)
        
        viewModel.beerModelOutput.withUnretained(self).emit(onNext: { owner, beers in
            owner.configureUI(with: beers)
        }).disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(beerIdLabel)
        view.addSubview(beerNameLabel)
        view.addSubview(beerTagLabel)
        view.addSubview(beerDescriptionLabel)
        
        beerIdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        beerNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerIdLabel.snp.bottom).offset(10)
        }
        
        beerTagLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerNameLabel.snp.bottom).offset(10)
        }
        
        beerDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerTagLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureUI(with model: [Beer]) {
        guard model.count == 1 else {
            print("BeerViewController configureUI occured")
            return
        }
        _ = model.map { beer in
            guard let id = beer.id,
                  let name = beer.name,
                  let tagline = beer.tagline,
                  let description = beer.description,
                  let imageString = beer.imageUrl else {
                        return
                  }
            
            beerIdLabel.text = "\(id)"
            beerNameLabel.text = name
            beerTagLabel.text = tagline
            beerDescriptionLabel.text = description
            beerImageView.setImage(with: imageString)
        }
    }
}
