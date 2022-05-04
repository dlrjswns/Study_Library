//
//  BeerRepositoryImpl.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import Alamofire
import RxSwift

class BeerRepositoryImpl: BeerRepository {
    
    public func fetchOneBeer() -> Observable<Result<[Beer], BeerError>> {
        return Observable.create { [weak self] emitter -> Disposable in
            self?.fetchPunkBeer(type: .beer) { result in
                switch result {
                    case .success(let oneBeer):
                        emitter.onNext(.success(oneBeer))
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    public func fetchBeers() -> Observable<Result<[Beer], BeerError>> {
        return Observable.create { [weak self] emitter -> Disposable in
            self?.fetchPunkBeer(type: .beers) { result in
                switch result {
                    case .success(let beers):
                        emitter.onNext(.success(beers))
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    public func fetchRandomBeer() -> Observable<Result<[Beer], BeerError>> {
        return Observable.create { [weak self] emitter -> Disposable in
            self?.fetchPunkBeer(type: .randomBeer) { result in
                switch result {
                    case .success(let randomBeer):
                        emitter.onNext(.success(randomBeer))
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    private func fetchPunkBeer(type: BeerAPIType, completion: @escaping (Result<[Beer], BeerError>) -> Void) {
        let router: URLRequestConvertible
        switch type {
            case .beer:
                router = Router.oneBeer
            case .beers:
                router = Router.beerList
            case .randomBeer:
                router = Router.randomBeer
        }
        
        AF.request(router).responseDecodable(of: [Beer].self) { response in
            if response.error != nil {
                let error = BeerError.decodeError
                completion(.failure(error))
            }
            
            if let oneBeer = response.value {
                completion(.success(oneBeer))
            }
        }
    }
}

enum BeerAPIType {
    case beer
    case beers
    case randomBeer
}

enum Router: URLRequestConvertible {
    case oneBeer, beerList, randomBeer
    
    var baseURL: URL {
        return URL(string: "https://api.punkapi.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
            case .oneBeer: return "/v2/beers/1"
            case .beerList: return "/v2/beers"
            case .randomBeer: return "/v2/beers/random"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
            case .oneBeer:
                return request
            case .beerList:
//                request = try JSONParameterEncoder().encode(parameters, into: request)
                  return request
            case.randomBeer:
                return request
        }
        
//        return request
    }
}
