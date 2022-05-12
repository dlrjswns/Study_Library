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
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
//        scrollView.verticalScrollIndicatorInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        return scrollView
    }()
    
    private let beerIdLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        return label
    }()
    
    private let beerNameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.isUserInteractionEnabled = true
        label.numberOfLines = 1
        label.textAlignment = .center
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
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let beerDescriptionLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .thin)
        label.numberOfLines = .max
        return label
    }()
    
    private let loadingView = LoadingView()
    private let emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        title = "Search Beer"
//        navigationController?.navigationItem.titleView = searchBar
        navigationItem.titleView = searchBar
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTappdNameLabel))
        beerNameLabel.addGestureRecognizer(gesture)
    }
    
    @objc func didTappdNameLabel() {
        beerNameLabel.numberOfLines = .max
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        beerImageView.snp.updateConstraints { make in
            make.width.height.equalTo(view.frame.width - 100)
        }
    }
    
    private func bind() {
        searchBar.rx.text.orEmpty
            .debounce(.seconds(1), scheduler: ConcurrentDispatchQueueScheduler.init(qos: .default))
            .distinctUntilChanged()
            .bind(to: viewModel.searchIdInput)
            .disposed(by: disposeBag)
        
        viewModel.beerErrorOutput.emit(onNext: { beerError in
            print("BeerErrorOutput occured = \(beerError.errorMessage)")
        }).disposed(by: disposeBag)
        
        viewModel.beerModelOutput.withUnretained(self).emit(onNext: { owner, beers in
            owner.configureUI(with: beers)
        }).disposed(by: disposeBag)
        
        viewModel.loadingCheckOutput.drive(onNext: { [weak self] loading in
            self?.loadingView.isHidden = !loading
        }).disposed(by: disposeBag)
        
        viewModel.emptyCheckOutput.drive(onNext: { [weak self] empty in
            self?.emptyView.isHidden = !empty
        }).disposed(by: disposeBag)
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        view.addSubview(loadingView)
        view.addSubview(emptyView)
        scrollView.addSubview(beerIdLabel)
        scrollView.addSubview(beerImageView)
        scrollView.addSubview(beerNameLabel)
        scrollView.addSubview(beerTagLabel)
        scrollView.addSubview(beerDescriptionLabel)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        beerIdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.top).offset(10)
        }
        
        beerImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerIdLabel.snp.bottom)
            make.width.height.equalTo(view.frame.width - 60)
        }
        
        beerNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerImageView.snp.bottom)
            make.left.right.equalToSuperview().inset(10)
//            make.width.height.equalTo(view.frame.width - 40)
        }
        
        beerTagLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(beerNameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
        }
        
        beerDescriptionLabel.snp.makeConstraints { make in
            make.centerX.bottom.equalToSuperview()
            make.top.equalTo(beerTagLabel.snp.bottom).offset(10)
//            make.width.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
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
