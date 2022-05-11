//
//  BeerListViewModel.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import RxSwift
import RxCocoa

protocol BeerListViewModelType {
    var disposeBag: DisposeBag { get set }
    var beerListModelOutput: Driver<[Beer]> { get }
    var beerListErrorOutput: Observable<BeerError> { get }
    var currentBeerCountOutput: Observable<IndexPath> { get }
}

class BeerListViewModel: BeerListViewModelType {
    
    private let usecase: BeerUsecase
    
    var disposeBag: DisposeBag = DisposeBag()
    
    //Input
    
    //Output
    let beerListModelOutput: Driver<[Beer]>
    let beerListErrorOutput: Observable<BeerError>
    let currentBeerCountOutput: Observable<IndexPath>
    
    init(usecase: BeerUsecase) {
        self.usecase = usecase
        
        let beerListModel = BehaviorRelay<[Beer]>(value: [])
        let beerListError = PublishSubject<BeerError>()
        let currentBeerCount = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
        
        beerListModelOutput = beerListModel.asDriver(onErrorJustReturn: [])
        beerListErrorOutput = beerListError.asObservable()
        currentBeerCountOutput = currentBeerCount.asObservable()
        
        usecase.fetchBeers(page: "1").subscribe(onNext: { result in
            switch result {
                case .success(let beers):
                    beerListModel.accept(beers)
                    currentBeerCount.accept(IndexPath(row: beers.count - 1, section: 0))
                case .failure(let error):
                    beerListError.onNext(error)
            }
        }).disposed(by: disposeBag)
    }
}
