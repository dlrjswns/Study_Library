//
//  KakaoMapRepositoryImpl.swift
//  KakaoMapPR
//
//  Created by 이건준 on 2022/05/23.
//

import RxSwift
import RxCocoa

protocol KakaoMapRepository {
    func fetchLocationWithKeyword(query: String) -> Observable<Result<[KakaoMapLocation], KakaoMapError>>
}

class KakaoMapRepositoryImpl: KakaoMapRepository {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
//    struct Constants {
//        static let kakaoMapSearchURL = "https://dapi.kakao.com/v2/local/search/address.json"
//    }
    
    func fetchLocationWithKeyword(query: String) -> Observable<Result<[KakaoMapLocation], KakaoMapError>> {
        guard let url = getKakaoMapSearchURLComponents(query: query).url else {
            return Observable.just(.failure(KakaoMapError.urlError))
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Authorization": "KakaoAK 290e68c139e07db6d13d94a07a62fd4e"
        ]
        
        
        return session.rx.data(request: request).map { data in
            do {
                let kakoMapLocations = try JSONDecoder().decode(KakaoMapLocations.self, from: data)
                print("resssss = \(kakoMapLocations.documents)")
                return .success(kakoMapLocations.documents)
            }
            catch {
                return .failure(KakaoMapError.decodeError)
            }
        }
    }
}

enum KakaoMapError: Error {
    case decodeError
    case urlError
}

extension KakaoMapRepositoryImpl {
    struct KakaoMapAPI {
        static let scheme = "https"
        static let host = "dapi.kakao.com"
        static let path = "/v2/local/search/keyword.json"
    }
    
    private func getKakaoMapSearchURLComponents(query: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = KakaoMapAPI.scheme
        components.host = KakaoMapAPI.host
        components.path = KakaoMapAPI.path
        components.queryItems = [
            URLQueryItem(name: "size", value: "15"),
            URLQueryItem(name: "query", value: query)
        ]
        return components
    }
}
