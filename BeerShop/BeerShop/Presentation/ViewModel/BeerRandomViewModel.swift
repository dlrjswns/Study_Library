//
//  BeerRandomViewModel.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/12.
//

import RxSwift
import RxCocoa

protocol BeerRandomViewModelType {
    var disposeBag: DisposeBag { get set }
    
    //Input
    var randomBeerButtonTapped: AnyObserver<Void> { get }
    
    //Output
    var randomBeerOutput: Observable<[Beer]> { get }
    var beerErrorOutput: Observable<BeerError> { get }
    var isLoadingOutput: Driver<Bool> { get }
}

class BeerRandomViewModel: BeerRandomViewModelType {
    
    private let usecase: BeerUsecase
    var disposeBag: DisposeBag = DisposeBag()
    
    //Input
    let randomBeerButtonTapped: AnyObserver<Void>
    
    //Output
    let randomBeerOutput: Observable<[Beer]>
    let beerErrorOutput: Observable<BeerError>
    let isLoadingOutput: Driver<Bool>
    
    init(usecase: BeerUsecase) {
        self.usecase = usecase
        
        let randomBeerRelay = BehaviorRelay<[Beer]>(value: [])
        let beerErrorRelay = PublishRelay<BeerError>()
        let randomBeerButtonTappedSubject = PublishSubject<Void>()
        let isLoadingBeerRelay = BehaviorRelay<Bool>(value: false)
        
        randomBeerOutput = randomBeerRelay.asObservable()
        beerErrorOutput = beerErrorRelay.asObservable()
        randomBeerButtonTapped = randomBeerButtonTappedSubject.asObserver()
        isLoadingOutput = isLoadingBeerRelay.asDriver(onErrorJustReturn: false)
        
        let randomBeerResult = randomBeerButtonTappedSubject
            .do(onNext: {isLoadingBeerRelay.accept(true)})
            .flatMap(usecase.fetchRandomBeer)
            .do(onNext: { _ in isLoadingBeerRelay.accept(false)})
            .asObservable().share()
        
        let randomBeer = randomBeerResult.map { result -> [Beer]? in
            guard case .success(let beers) = result else {
                return nil
            }
            
            return beers
        }
        
        randomBeer.subscribe(onNext: { beers in
            
            guard let beers = beers else {
                return
            }
            
            randomBeerRelay.accept(beers)
        }).disposed(by: disposeBag)
        
        let beerError = randomBeerResult.map { result -> BeerError? in
            guard case .failure(let error) = result else {
                return nil
            }
            
            return error
        }
        
        beerError.subscribe(onNext: { error in
            
            guard let error = error else {
                return
            }
            
            beerErrorRelay.accept(error)
        }).disposed(by: disposeBag)
    }
    
}
