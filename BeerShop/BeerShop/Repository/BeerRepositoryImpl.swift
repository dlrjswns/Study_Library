//
//  BeerRepositoryImpl.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import Alamofire
import RxSwift

class BeerRepositoryImpl: BeerRepository {
    
    public func fetchOneBeer(id: String) -> Observable<Result<[Beer], BeerError>> {
        return Observable.create { [weak self] emitter -> Disposable in
            self?.fetchPunkBeer(id: id, type: .beer) { result in
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
    
    public func fetchBeers(page: String) -> Observable<Result<[Beer], BeerError>> {
        return Observable.create { [weak self] emitter -> Disposable in
            self?.fetchPunkBeer(page: page, type: .beers) { result in
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
    
    private func fetchPunkBeer(id: String = "1", page: String = "1", type: BeerType, completion: @escaping (Result<[Beer], BeerError>) -> Void) {

        let router: URLRequestConvertible
        switch type {
            case .beer:
                router = Router.oneBeer(id)
            case .beers:
                router = Router.beerList(["page": page, "per_page": "25"])
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

enum BeerType: Int {
    case beer = 0
    case beers = 1
    case randomBeer = 2
}

enum Router: URLRequestConvertible {
    case oneBeer(String), beerList([String: String]), randomBeer
    
    var baseURL: URL {
        return URL(string: "https://api.punkapi.com")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
            case .oneBeer(let id): return "/v2/beers/\(id)"
            case .beerList: return "/v2/beers"
            case .randomBeer: return "/v2/beers/random"
        }
    }
//    ?page=2&per_page=80
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        switch self {
            case .oneBeer:
                print("request = \(request)")
                return request
            case .beerList(let parameters):
                request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
                return request
            case.randomBeer:
                return request
        }
        
//        return request
    }
}
