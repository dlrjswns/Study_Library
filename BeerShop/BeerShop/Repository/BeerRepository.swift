//
//  BeerRepository.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import RxSwift

protocol BeerRepository {
    func fetchOneBeer(id: String) -> Observable<Result<[Beer], BeerError>>
    func fetchBeers() -> Observable<Result<[Beer], BeerError>>
    func fetchRandomBeer() -> Observable<Result<[Beer], BeerError>>
}

enum BeerError: Error {
    case decodeError
}
