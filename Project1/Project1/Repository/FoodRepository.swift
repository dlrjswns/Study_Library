//
//  FoodRepository.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import RxSwift

protocol FoodRepository {
    func fetchFood() -> Observable<Result<[FoodEntity], FoodError>>
}

enum FoodError: Error {
    case urlError
    case decodeError
    
    var errorMessage: String {
        switch self {
            case .decodeError:
                return "Decode error occured"
            case .urlError:
                return "URL error occured"
        }
    }
}
