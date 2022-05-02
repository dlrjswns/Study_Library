//
//  MainCoordinator.swift
//  BeerShop
//
//  Created by 이건준 on 2022/05/02.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    struct Dependency {
        let beerListControllerFactory: () -> BeerListController
    }
    
    init(dependency: Dependency) {
        beerListControllerFactory = dependency.beerListControllerFactory
    }
    
    let beerListControllerFactory: () -> BeerListController
    
    func start() {
        let beerListVC = beerListControllerFactory()
        navigationController?.setViewControllers([beerListVC], animated: true)
    }
    
}
