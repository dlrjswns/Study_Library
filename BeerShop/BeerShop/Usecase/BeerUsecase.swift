//
//  BeerUsecase.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/04.
//

import Foundation

class BeerUsecase {
    
    private let repository: BeerRepository
    
    init(repository: BeerRepository) {
        self.repository = repository
    }
}
