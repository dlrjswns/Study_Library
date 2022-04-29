//
//  FoodViewModelType.swift
//  Project1
//
//  Created by 이건준 on 2022/04/28.
//

import RxSwift
import RxCocoa

protocol FoodViewModelType {
    var disposeBag: DisposeBag { get set }
    var foodModelOutput: Driver<[FoodEntity]> { get }
    var foodErrorOutput: Signal<FoodError> { get }
    var foodMockOutput: Driver<[FoodEntity]> { get }
}
