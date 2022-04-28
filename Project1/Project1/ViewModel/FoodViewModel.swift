//
//  FoodViewModel.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import RxSwift
import RxCocoa

class FoodViewModel: FoodViewModelType {
    private let usecase: FoodUsecase
    
    //Output
    let foodModelObservable: Driver<[FoodEntity]>
    let foodErrorObservable: Observable<FoodError>
    
    init(usecase: FoodUsecase) {
        self.usecase = usecase
        
        let foodModelRelay = BehaviorRelay<[FoodEntity]>(value: [])
        self.foodModelObservable = foodModelRelay.asDriver(onErrorJustReturn: [])
        
        
        usecase.fetchFood().subscribe(onNext: { result in
            switch result {
                case .success(let foodEntities):
                    foodModelRelay.accept(foodEntities)
                case .failure(let error):
            }
        })
    }
}
