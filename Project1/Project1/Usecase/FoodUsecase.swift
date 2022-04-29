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
    
    func createMock() -> Observable<[FoodEntity]> {
        Observable.create { event in
            event.onNext([FoodEntity(foodImageID: nil, foodStoreID: nil, foodStoreName: "교촌치킨", resionName: "서울", menuID: nil, foodImageString: nil), FoodEntity(foodImageID: nil, foodStoreID: nil, foodStoreName: "BBQ", resionName: "서울", menuID: nil, foodImageString: nil), FoodEntity(foodImageID: nil, foodStoreID: nil, foodStoreName: "페리카나", resionName: "서울", menuID: nil, foodImageString: nil), FoodEntity(foodImageID: nil, foodStoreID: nil, foodStoreName: "슈프림치킨", resionName: "서울", menuID: nil, foodImageString: nil)])
            event.onCompleted()
            return Disposables.create()
        }
    }
}
