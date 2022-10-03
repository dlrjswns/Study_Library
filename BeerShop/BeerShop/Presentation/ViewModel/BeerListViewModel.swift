//
//  BeerListViewModel.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import RxSwift
import RxCocoa

protocol BeerListViewModelType {
    //Input
    var pageInput: AnyObserver<String> { get }
    var fetchInput: AnyObserver<Void> { get }
    
    //Output
    var disposeBag: DisposeBag { get }
    var beerListModelOutput: Driver<[Beer]> { get }
    var beerListErrorOutput: Observable<BeerError> { get }
    var currentBeerCountOutput: Observable<IndexPath> { get }
    var beerNetworkOutput: Driver<Bool> { get }
}

class BeerListViewModel: BeerListViewModelType {
    
    private let usecase: BeerUsecase
    
    var disposeBag: DisposeBag = DisposeBag()
    
    //Input
    let pageInput: AnyObserver<String>
    let fetchInput: AnyObserver<Void>
    
    //Output
    let beerListModelOutput: Driver<[Beer]>
    let beerListErrorOutput: Observable<BeerError>
    let currentBeerCountOutput: Observable<IndexPath>
    let beerNetworkOutput: Driver<Bool>
    
    init(usecase: BeerUsecase) {
        self.usecase = usecase
        
        let beerListModel = BehaviorRelay<[Beer]>(value: [])
        let beerListError = PublishSubject<BeerError>()
        let currentBeerCount = BehaviorRelay<IndexPath>(value: IndexPath(row: 0, section: 0))
        let beerNetworkRelay = BehaviorRelay<Bool>(value: false)
        let pageSubject = BehaviorSubject<String>(value: "1")
        let fetchSubject = PublishSubject<Void>()
        
        beerListModelOutput = beerListModel.asDriver(onErrorJustReturn: [])
        beerListErrorOutput = beerListError.asObservable()
        currentBeerCountOutput = currentBeerCount.asObservable()
        beerNetworkOutput = beerNetworkRelay.asDriver(onErrorJustReturn: false)
        pageInput = pageSubject.asObserver()
        fetchInput = fetchSubject.asObserver()
        
//        usecase.fetchBeers(page: "1").subscribe(onNext: { result in
//            switch result {
//                case .success(let beers):
//                    beerNetworkRelay.accept(true)
//                    beerListModel.accept(beers)
//                    currentBeerCount.accept(IndexPath(row: beers.count - 1, section: 0))
//                case .failure(let error):
//                    beerNetworkRelay.accept(false)
//                    beerListError.onNext(error)
//            }
//        }).disposed(by: disposeBag)
        
        Observable.combineLatest(pageSubject, fetchSubject)
            .subscribe(onNext: { fetch in
//                guard let `self` = self else { return }
                pageSubject.onNext(String(Int(fetch.0)! + 1))
            }).disposed(by: disposeBag)
        
//        let fetchSuccess = fetchResult.map { result ->  [Beer]? in
//            guard case .success(let value) = result else { return nil }
//            return value
//        }
//
//        let fetchFailure = fetchResult.map { result -> BeerError? in
//            guard case .failure(let error) = result else { return nil }
//            return error
//        }
//
//        fetchSuccess.bind(to: beerListModel)
//        fetchSubject.subscribe(onNext: { _ in
//            pageSubject.map { pageString in
//                let pageInt = Int(pageString)
//            }
//        }).disposed(by: disposeBag)
        
        pageSubject.flatMap(usecase.fetchBeers(page:)).subscribe(onNext: { result in
            switch result {
                case .success(let beers):
                    beerNetworkRelay.accept(true)
                    beerListModel.accept(beers)
                    currentBeerCount.accept(IndexPath(row: beers.count - 1, section: 0))
                case .failure(let error):
                    beerNetworkRelay.accept(false)
                    beerListError.onNext(error)
            }
        }).disposed(by: disposeBag)
    }
}
