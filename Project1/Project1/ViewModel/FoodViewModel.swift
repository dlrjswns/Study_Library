//
//  FoodViewModel.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import RxSwift
import RxCocoa

class FoodViewModel: FoodViewModelType {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let usecase: FoodUsecase
    
    //Output
    let foodModelOutput: Driver<[FoodEntity]>
    let foodErrorOutput: Signal<FoodError>
    let foodMockOutput: Driver<[FoodEntity]>
    
    init(usecase: FoodUsecase) {
        self.usecase = usecase
        
        let foodModelRelay = BehaviorRelay<[FoodEntity]>(value: [])
        let foodErrorRelay = PublishRelay<FoodError>()
        let foodMockRelay = BehaviorRelay<[FoodEntity]>(value: [])
        
        self.foodModelOutput = foodModelRelay.asDriver(onErrorJustReturn: [])
        self.foodErrorOutput = foodErrorRelay.asSignal(onErrorJustReturn: .customError("foodErrorRelay onErrorJustReturn called"))
        self.foodMockOutput = foodMockRelay.asDriver(onErrorJustReturn: [])
        
        usecase.createMock().subscribe(onNext: { mock in
//            print("mock = \(mock)")
            foodMockRelay.accept(mock)
        }).disposed(by: disposeBag)
        
//        usecase.fetchFood().subscribe(onNext: { result in
//            switch result {
//                case .success(let foodEntities):
//                    print("su")
//                    foodModelRelay.accept(foodEntities)
//                case .failure(let error):
//                    print("fail")
//                    foodErrorRelay.accept(error)
//            }
//        }).disposed(by: disposeBag)
    }
}
