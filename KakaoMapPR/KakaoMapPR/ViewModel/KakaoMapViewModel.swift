//
//  KakaoMapViewModel.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import RxSwift
import RxCocoa

protocol KakaoMapViewModelType {
    
}

class KakaoMapViewModel: KakaoMapViewModelType {
    private let usecase: KakaoMapUsecase
    
    var disposeBag = DisposeBag()
    
    //Input
    let querySearch: AnyObserver<String>
    
    init(usecase: KakaoMapUsecase) {
        self.usecase = usecase
        
        let querySearchRelay = BehaviorSubject<String>(value: "")
        querySearch = querySearchRelay.asObserver()
        
        querySearchRelay.subscribe(onNext: { query in
            print("query = \(query)")
        }).disposed(by: disposeBag)
        
        let querySearchResult = querySearchRelay.flatMap(usecase.fetchLocationWithKeyword(query:))
        let querySearchSuccess = querySearchResult.map { result -> KakaoMapLocations? in
            guard case .success(let kakaoMapLocations) = result else { return nil }
            return kakaoMapLocations
        }
        
        let querySearchFailure = querySearchResult.map { result -> KakaoMapError? in
            guard case .failure(let mapError) = result else { return nil }
            return mapError
        }
    }
}
