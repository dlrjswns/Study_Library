//
//  AppDependency.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import Foundation

struct AppDenpency {
    let mainCoordinator: MainCoordinator
}

extension AppDenpency {
    static func resolve() -> AppDenpency {
        
        let beerListControllerFactory: () -> BeerListController = {
            return .init()
        }
        
        let mainCoordinator: MainCoordinator = .init(dependency: .init(beerListControllerFactory: beerListControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
