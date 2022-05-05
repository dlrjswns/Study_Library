//
//  BeerUsecase.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import RxSwift

protocol BeerUsecase {
    func fetchOneBeer(id: String) -> Observable<Result<[Beer], BeerError>>
    func fetchBeers() -> Observable<Result<[Beer], BeerError>>
    func fetchRandomBeer() -> Observable<Result<[Beer], BeerError>>
}
