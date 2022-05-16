//
//  BeerRandomViewController.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/12.
//

import UIKit
import SnapKit
import RxSwift

class BeerRandomViewController: UIViewController {
    
    private let viewModel: BeerRandomViewModelType
    private var disposeBag = DisposeBag()
//    private var randomBeer: Beer?
    
    init(viewModel: BeerRandomViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let congraturationView: RandomSuccessView = {
       let vw = RandomSuccessView()
        vw.isHidden = true
        return vw
    }()
    
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
    
    private let randomButton: UIButton = {
       let button = UIButton()
        button.setTitle("Get Beer", for: .normal)
        button.backgroundColor = .systemPink
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        
        randomButton.rx.tap.throttle(.seconds(1), scheduler: MainScheduler.instance).bind(to: viewModel.randomBeerButtonTapped)
            .disposed(by: disposeBag)
        
        
    }
    
    private func configureUI(with model: Beer) {
        guard let id = model.id,
              let imageUrl = model.imageUrl,
              let name = model.name,
              let tagline = model.tagline,
              let description = model.description else { return }
        
        beerIdLabel.text = "\(id)"
        beerNameLabel.text = name
        beerImageView.setImage(with: imageUrl)
        beerTagLineLabel.text = tagline
        beerDescriptionLabel.text = description
    }
    
    private func bind() {
        viewModel.randomBeerOutput.subscribe(onNext: { beers in
            beers.forEach { [weak self] beer in
                self?.configureUI(with: beer)
            }
        }).disposed(by: disposeBag)
        
        viewModel.beerErrorOutput.subscribe(onNext: { error in
            print("BeerRandomVC bind() beerError called - \(error.errorMessage) ")
        }).disposed(by: disposeBag)
        
        viewModel.isLoadingOutput.drive(onNext: { [weak self] loading in
            self?.congraturationView.isHidden = !loading
        }).disposed(by: disposeBag)
    }
    
    //MARK: -Configure
    private func configureUI() {
        view.addSubview(scrollView)
        view.addSubview(congraturationView)
        view.addSubview(randomButton)
        scrollView.addSubview(beerIdLabel)
        scrollView.addSubview(beerImageView)
        scrollView.addSubview(beerNameLabel)
        scrollView.addSubview(beerTagLineLabel)
        scrollView.addSubview(beerDescriptionLabel)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
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
        
        randomButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-90)
            make.width.height.equalTo(100)
        }
        randomButton.layer.cornerRadius = 25
        
        congraturationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
