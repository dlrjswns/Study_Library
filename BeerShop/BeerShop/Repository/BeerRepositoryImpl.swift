//
//  BeerRepositoryImpl.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import Alamofire
import RxSwift

class BeerRepositoryImpl: BeerRepository {
    func fetchOneBeer() {
        AF.request(Router.oneBeer).responseDecodable(of: [Beer].self) { data in
            print("data = \(data)")
        }
    }
}

//https://api.punkapi.com/v2/beers/1
//https://api.punkapi.com/v2/beers/random
//https://api.punkapi.com/v2/beers

enum Router: URLRequestConvertible {
    case oneBeer, beerList([String: String]), randomBeer
    
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
            case let .beerList(parameters):
                request = try JSONParameterEncoder().encode(parameters, into: request)
            case.randomBeer:
                return request
        }
        
        return request
    }
}
