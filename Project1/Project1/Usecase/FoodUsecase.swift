//
//  FoodUsecase.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import RxSwift
import RxCocoa

class FoodUsecase {
    private let repository: FoodRepository
    
    init(repository: FoodRepository) {
        self.repository = repository
    }
    
    func fetchFood() -> Observable<Result<[FoodEntity], FoodError>> {
        return repository.fetchFood()
    }
}
