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
    var errorMessageOutput: Signal<KakaoMapError> { get }
    var mapLocationOutput: Driver<MapLocation> { get }
    
    //Input
    var querySearch: AnyObserver<String> { get }
    var mapLocationInput: AnyObserver<MapLocation> { get }
}

class KakaoMapViewModel: KakaoMapViewModelType {
    private let usecase: KakaoMapUsecase
    
    var disposeBag = DisposeBag()
    
    //Ouput
    let searchResultOutput: Driver<[KakaoMapLocation]>
    let errorMessageOutput: Signal<KakaoMapError>
    let mapLocationOutput: Driver<MapLocation>
    
    //Input
    let querySearch: AnyObserver<String>
    let mapLocationInput: AnyObserver<MapLocation>
    
    init(usecase: KakaoMapUsecase) {
        self.usecase = usecase
        
        let querySearchRelay = BehaviorSubject<String>(value: "")
        let searchResultRelay = BehaviorRelay<[KakaoMapLocation]>(value: [])
        let errorMessageSubject = PublishRelay<KakaoMapError>()
        let mapLocationRelay = BehaviorSubject<MapLocation>(value: MapLocation(latitude: 37.50129, longitude: 127.12865))
        
        querySearch = querySearchRelay.asObserver()
        searchResultOutput = searchResultRelay.asDriver(onErrorJustReturn: [])
        errorMessageOutput = errorMessageSubject.asSignal(onErrorJustReturn: .customError("KakaoMapViewModel called - errorMessageSubject error occured"))
        mapLocationOutput = mapLocationRelay.asDriver(onErrorJustReturn: MapLocation(latitude: 37.50129, longitude: 127.12865))
        mapLocationInput = mapLocationRelay.asObserver()
        
        querySearchRelay.subscribe(onNext: { query in
            print("query = \(query)")
        }).disposed(by: disposeBag)
        
        let querySearchResult = querySearchRelay.filter{ $0.count != 0 }.distinctUntilChanged().flatMapLatest(usecase.fetchLocationWithKeyword(query:)).share()
        
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
        
        querySearchFailure.subscribe(onNext: { error in
            guard let error = error else { return }
            errorMessageSubject.accept(error)
        }).disposed(by: disposeBag)
    }
}
