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
        
        let repository: BeerRepository = BeerRepositoryImpl()
        
        let beerListViewControllerFactory: () -> BeerListViewController = {
            let usecase = BeerUsecaseImpl(repository: repository)
            let viewModel = BeerListViewModel(usecase: usecase)
            return .init(viewModel: viewModel)
        }
        
        let beerViewControllerFactory: () -> BeerViewController = {
            let usecase = BeerUsecaseImpl(repository: repository)
            let viewModel = BeerViewModel(usecase: usecase)
            return .init(viewModel: viewModel)
        }
        
        let beerDetailViewControllerFactory: (Beer) -> BeerDetailViewController = { beer in
            return .init(dependency: .init(selectedBeer: beer))
        }
        
        let beerRandomViewControllerFactory: () -> BeerRandomViewController = {
            let usecase = BeerUsecaseImpl(repository: repository)
            let viewModel = BeerRandomViewModel(usecase: usecase)
            return .init(viewModel: viewModel)
        }
        
        let mainCoordinator: MainCoordinator = .init(dependency: .init(beerListViewControllerFactory: beerListViewControllerFactory, beerViewControllerFactory: beerViewControllerFactory, beerDetailViewControllerFactory: beerDetailViewControllerFactory, beerRandomViewControllerFactory: beerRandomViewControllerFactory))
        
        return .init(mainCoordinator: mainCoordinator)
    }
}
