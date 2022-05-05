//
//  BeerViewModel.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/05.
//

import RxSwift
import RxCocoa

protocol BeerViewModelType {
    var disposeBag: DisposeBag { get set }
    
    // Input
    var searchIdInput: AnyObserver<String> { get }
    
    // Output
    var beerModelOutput: Signal<[Beer]> { get }
    var beerErrorOutput: Signal<BeerError> { get }
}

class BeerViewModel: BeerViewModelType {
    private let usecase: BeerUsecase
    var disposeBag: DisposeBag = DisposeBag()
    
    // Input
    let searchIdInput: AnyObserver<String>
    
    // Output
    let beerModelOutput: Signal<[Beer]>
    let beerErrorOutput: Signal<BeerError>
    
    init(usecase: BeerUsecase) {
        self.usecase = usecase
        
        let searchIdChanged = PublishSubject<String>()
        let beerModelRelay = PublishRelay<[Beer]>()
        let beerErrorMessage = PublishRelay<BeerError>()
        
        searchIdInput = searchIdChanged.asObserver()
        beerModelOutput = beerModelRelay.asSignal(onErrorJustReturn: [])
        beerErrorOutput = beerErrorMessage.asSignal(onErrorJustReturn: .customError("BeerViewModel beerErrorMessage onErrorJustReturn"))
        
        let searchBeerWithId = searchIdChanged.flatMapLatest(usecase.fetchOneBeer(id:))
        let searchResult = searchBeerWithId.map { result -> [Beer]? in
            guard case .success(let beers) = result else {
                return nil
            }
            
            return beers
        }
        
        searchResult.subscribe(onNext: { beers in
            guard let beers = beers else {
                return
            }
            
            beerModelRelay.accept(beers)
        }).disposed(by: disposeBag)
        
        
        let searchError = searchBeerWithId.map { result -> BeerError? in
            guard case .failure(let error) = result else {
                return nil
            }
            
            return error
        }
        
        searchError.subscribe(onNext: { error in
            guard let error = error else {
                return
            }
            
            beerErrorMessage.accept(error)
        }).disposed(by: disposeBag)
        
//        searchIdSubject.bind(to: usecase.fetchOneBeer).disposed(by: disposeBag)
//        sear
    }
}
