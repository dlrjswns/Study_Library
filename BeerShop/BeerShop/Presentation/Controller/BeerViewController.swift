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
    
    private let tagLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
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
    }
    
    private func configureUI() {
        
    }
}
