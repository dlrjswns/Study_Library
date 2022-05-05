//
//  BeerUsecase.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import RxSwift

class BeerUsecaseImpl: BeerUsecase {
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
    
    func fetchOneBeer(id: String) -> Observable<Result<[Beer], BeerError>> {
        return repository.fetchOneBeer(id: id)
    }
    
    func fetchBeers() -> Observable<Result<[Beer], BeerError>> {
        return repository.fetchBeers()
    }
    
    func fetchRandomBeer() -> Observable<Result<[Beer], BeerError>> {
        return repository.fetchRandomBeer()
    }
}
