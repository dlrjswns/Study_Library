//
//  KakaoMapViewModel.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import RxSwift
import RxCocoa

protocol KakaoMapViewModelType {
    //Ouput
    var searchResultOutput: Driver<[KakaoMapLocation]> { get }
    
    //Input
    var querySearch: AnyObserver<String> { get }
}

class KakaoMapViewModel: KakaoMapViewModelType {
    private let usecase: KakaoMapUsecase
    
    var disposeBag = DisposeBag()
    
    //Ouput
    let searchResultOutput: Driver<[KakaoMapLocation]>
    
    //Input
    let querySearch: AnyObserver<String>
    
    init(usecase: KakaoMapUsecase) {
        self.usecase = usecase
        
        let querySearchRelay = BehaviorSubject<String>(value: "")
        let searchResultRelay = BehaviorRelay<[KakaoMapLocation]>(value: [])
        
        querySearch = querySearchRelay.asObserver()
        searchResultOutput = searchResultRelay.asDriver(onErrorJustReturn: [])
        
        querySearchRelay.subscribe(onNext: { query in
            print("query = \(query)")
        }).disposed(by: disposeBag)
        
        let querySearchResult = querySearchRelay.filter{ $0.count != 0 }.distinctUntilChanged().flatMap(usecase.fetchLocationWithKeyword(query:))
        
        let querySearchSuccess = querySearchResult.map { result -> [KakaoMapLocation]? in
            guard case .success(let kakaoMapLocations) = result else { return nil }
            return kakaoMapLocations
        }
        
        querySearchSuccess.subscribe(onNext: { kakaoMapLocations in
            guard let kakaoMapLocations = kakaoMapLocations else { return }
            searchResultRelay.accept(kakaoMapLocations)
        }).disposed(by: disposeBag)
        
        let querySearchFailure = querySearchResult.map { result -> KakaoMapError? in
            guard case .failure(let mapError) = result else { return nil }
            return mapError
        }
    }
}
