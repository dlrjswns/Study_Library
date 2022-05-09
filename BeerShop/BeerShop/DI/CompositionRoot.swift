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
        
        let beerListViewControllerFactory: () -> BeerListViewController = {
            let repository = BeerRepositoryImpl()
            let usecase = BeerUsecaseImpl(repository: repository)
            let viewModel = BeerListViewModel(usecase: usecase)
            return .init(viewModel: viewModel)
        }
        
        let beerViewControllerFactory: () -> BeerViewController = {
            let repository = BeerRepositoryImpl()
            let usecase = BeerUsecaseImpl(repository: repository)
            let viewModel = BeerViewModel(usecase: usecase)
            return .init(viewModel: viewModel)
        }
        
        let beerDetailViewControllerFactory: (Beer) -> BeerDetailViewController = { beer in
            return .init(dependency: .init(selectedBeer: beer))
        }
        
        let mainCoordinator: MainCoordinator = .init(dependency: .init(beerListViewControllerFactory: beerListViewControllerFactory, beerViewControllerFactory: beerViewControllerFactory, beerDetailViewControllerFactory: beerDetailViewControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
