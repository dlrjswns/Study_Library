//
//  BeerRepository.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import RxSwift

protocol BeerRepository {
    func fetchBeer<T>() -> Observable<Result<T, BeerError>> where T: Decodable
    func fetchOneBeer(id: String) -> Observable<Result<[Beer], BeerError>>
    func fetchBeers(page: String) -> Observable<Result<[Beer], BeerError>>
    func fetchRandomBeer() -> Observable<Result<[Beer], BeerError>>
}

enum BeerError: Error {
    case decodeError
    case customError(String)
    
    var errorMessage: String {
        switch self {
        case .decodeError:
            return "Repository decode error occured"
        case .customError(let errorMessage):
            return errorMessage
        }
    }
}
