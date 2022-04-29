//
//  FoodRepositoryImpl.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import Alamofire
import RxSwift
import RxCocoa

class FoodRepositoryImpl: FoodRepository {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func fetchFood() -> Observable<Result<[FoodEntity], FoodError>> {
        guard let url = getFoodURLComponents().url else {
            let error = FoodError.urlError
            return .just(.failure(error))
        }
        print("url = \(url)")
        return session.rx.data(request: URLRequest(url: url)).map { data in
            print("dfasfadfsasfㄹㅇㄴㅁㄹ")
            do {
                let foodEntities = try JSONDecoder().decode([FoodEntity].self, from: data)
                print("fl;dsafjas;lfj")
                return .success(foodEntities)
            }
            catch {
                let error = FoodError.decodeError
                print("제발뭐야 대체")
                return .failure(error)
            }
        }
    }
}

extension FoodRepositoryImpl {
    struct FoodAPI {
        static let scheme = "https"
        static let host = "api.odcloud.kr/api"
        static let path = "/15096719/v1/uddi:97c65bfc-32e9-40d7-bc8e-b9b56ac3129c"
    }
    
    private func getFoodURLComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = FoodAPI.scheme
        components.host = FoodAPI.host
        components.path = FoodAPI.path
        return components
    }
}
