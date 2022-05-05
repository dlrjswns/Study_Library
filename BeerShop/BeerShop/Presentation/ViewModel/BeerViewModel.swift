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
    var searchIdInput: AnyObserver<String> { get }
    var beerModelOutput: Signal<[Beer]> { get }
}

class BeerViewModel: BeerViewModelType {
    private let usecase: BeerUsecase
    var disposeBag: DisposeBag = DisposeBag()
    
    // Input
    let searchIdInput: AnyObserver<String>
    
    // Output
    let beerModelOutput: Signal<[Beer]>
    
    init(usecase: BeerUsecase) {
        self.usecase = usecase
        
        let searchIdSubject = PublishSubject<String>()
        let beerModelRelay = PublishRelay<[Beer]>()
        
        searchIdInput = searchIdSubject.asObserver()
        beerModelOutput = beerModelRelay.asSignal(onErrorJustReturn: [])
        
        searchIdSubject.subscribe(onNext: { searhId in
            print("id = \(searhId)")
        }).disposed(by: disposeBag)
        
//        searchIdSubject.bind(to: usecase.fetchOneBeer).disposed(by: disposeBag)
//        sear
    }
}
