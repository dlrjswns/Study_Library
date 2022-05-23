//
//  KakaoMapUsecase.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import RxSwift

protocol KakaoMapUsecase {
    func fetchLocationWithKeyword(query: String) -> Observable<Result<KakaoMapLocations, KakaoMapError>>
}

class KakaoMapUsecaseImpl: KakaoMapUsecase {
    
    private let repository: KakaoMapRepository
    
    init(repository: KakaoMapRepository) {
        self.repository = repository
    }
    
    func fetchLocationWithKeyword(query: String) -> Observable<Result<KakaoMapLocations, KakaoMapError>> {
        return repository.fetchLocationWithKeyword(query: query)
    }
    
}
